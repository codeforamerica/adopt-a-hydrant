require 'open-uri'
require 'csv'

class Thing < ActiveRecord::Base
  acts_as_paranoid
  extend Forwardable
  include ActiveModel::ForbiddenAttributesProtection

  VALID_DRAIN_TYPES = ['Storm Water Inlet Drain', 'Catch Basin Drain'].freeze

  belongs_to :user
  def_delegators :reverse_geocode, :city, :country, :country_code,
                 :full_address, :state, :street_address, :street_name,
                 :street_number, :zip
  has_many :reminders
  validates :city_id, uniqueness: true, allow_nil: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :name, obscenity: true

  scope :adopted, -> { where.not(user_id: nil) }

  def self.find_closest(lat, lng, limit = 10)
    query = <<-SQL
      SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance
      FROM things
      WHERE deleted_at is NULL
      ORDER BY distance
      LIMIT ?
      SQL
    find_by_sql([query, lat.to_f, lng.to_f, lat.to_f, limit.to_i])
  end

  def reverse_geocode
    @reverse_geocode ||= Geokit::Geocoders::MultiGeocoder.reverse_geocode([lat, lng])
  end

  def adopted?
    !user.nil?
  end

  # Link to more details about type of Thing
  #
  # Currently hardcoding since we only have one special case, but we should
  # move this into the database if we add an additional
  def detail_link
    return 'http://sfwater.org/index.aspx?page=399' if system_use_code == 'MS4'

    nil
  end

  # TODO(jszwedko) Move the below into a separate model

  def self._is_integer?(string)
    true if Integer(string) rescue false
  end

  def self._import_temp_things(source_url)
    insert_statement_id = SecureRandom.uuid

    conn = ActiveRecord::Base.connection
    conn.execute(<<-SQL)
    CREATE TEMPORARY TABLE "temp_thing_import" (
    id serial,
    name varchar,
    lat numeric(16,14),
    lng numeric(17,14),
    city_id integer,
    system_use_code varchar)
SQL
    conn.raw_connection.prepare(insert_statement_id, 'INSERT INTO temp_thing_import (name, lat, lng, city_id, system_use_code) VALUES($1, $2, $3, $4, $5)')

    csv_string = open(source_url).read
    CSV.parse(csv_string, headers: true).each do |thing|
      city_id = thing['PUC_Maximo_Asset_ID'].gsub!('N-', '')

      next unless ['Storm Water Inlet Drain', 'Catch Basin Drain'].include?(thing['Drain_Type'])
      next unless self._is_integer?(city_id)

      (lat, lng) = thing['Location'].delete('()').split(',').map(&:strip)

      conn.raw_connection.exec_prepared(insert_statement_id, [
        thing['Drain_Type'],
        lat,
        lng,
        city_id,
        thing['System_Use_Code'],
      ])
    end

    conn.execute('CREATE INDEX "temp_thing_import_city_id" ON temp_thing_import(city_id)')
  end

  def self._delete_non_existing_things()
    deleted_things = ActiveRecord::Base.connection.execute(<<-SQL)
UPDATE things
SET deleted_at = NOW()
WHERE things.city_id NOT IN (SELECT city_id from temp_thing_import)
RETURNING things.city_id, things.user_id
SQL
    deleted_things.partition { |thing| thing["user_id"].present? }
  end

  def self._upsert_things()
    created_things = ActiveRecord::Base.connection.execute(<<-SQL)
SELECT temp_thing_import.city_id
FROM things
RIGHT JOIN temp_thing_import ON temp_thing_import.city_id = things.city_id
WHERE things.id IS NULL
SQL

    ActiveRecord::Base.connection.execute(<<-SQL)
INSERT INTO things(name, lat, lng, city_id, system_use_code)
SELECT name, lat, lng, city_id, system_use_code FROM temp_thing_import
ON CONFLICT(city_id) DO UPDATE SET
  lat = EXCLUDED.lat,
  lng = EXCLUDED.lng,
  name = CASE
           WHEN things.user_id IS NOT NULL THEN things.name
           ELSE EXCLUDED.name
         END,
  deleted_at = NULL
SQL

  created_things

  end

  def self.load_things(source_url)
    Rails.logger.info('Downloading Things... ... ...')

    ActiveRecord::Base.transaction do
      _import_temp_things(source_url)

      deleted_things_with_adoptee, deleted_things_no_adoptee = _delete_non_existing_things()
      created_things = _upsert_things()

      ThingMailer.thing_update_report(deleted_things_with_adoptee, deleted_things_no_adoptee, created_things).deliver_now
    end
  end
end
