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

  def self._get_parsed_things_csv(source_url)
    csv_string = open(source_url).read
    CSV.parse(csv_string, headers: true)
  end

  def self._delete_non_existing_things(things_from_source)
    city_ids = things_from_source.map do |thing|
      thing['PUC_Maximo_Asset_ID'].gsub('N-', '').to_i
    end

    things_to_delete = Thing.where.not(city_id: city_ids)
    things_to_delete.each(&:destroy!)

    things_to_delete.partition { |thing| thing.user_id.present? }
  end

  def self._thing_params(thing_blob)
    (lat, lng) = thing_blob['Location'].delete('()').split(',').map(&:strip)
    {
      name: thing_blob['Drain_Type'],
      system_use_code: thing_blob['System_Use_Code'],
      lat: lat,
      lng: lng,
    }
  end

  def self.city_id_for_thing_blob(thing_blob)
    thing_blob['PUC_Maximo_Asset_ID'].gsub('N-', '').to_i
  end

  def self.stored_city_ids
    Thing.unscoped.pluck(:city_id)
  end

  def self._thing_blobs_to_update(thing_blobs)
    thing_blobs.select do |thing_blob|
      stored_city_ids.include?(city_id_for_thing_blob(thing_blob))
    end
  end

  def self._update_things(thing_blobs)
    _thing_blobs_to_update(thing_blobs).each do |thing_blob|
      thing = Thing.unscoped.find_by(city_id: city_id_for_thing_blob(thing_blob))
      Rails.logger.info("Updating thing #{thing.city_id}")
      thing.restore! if thing.deleted_at?
      thing.update!(_thing_params(thing_blob))
    end
  end

  def self._thing_blobs_to_create(thing_blobs)
    thing_blobs.reject do |thing_blob|
      (stored_city_ids.include?(city_id_for_thing_blob(thing_blob)) ||
       !VALID_DRAIN_TYPES.include?(thing_blob['Drain_Type']))
    end
  end

  def self._create_things(thing_blobs)
    _thing_blobs_to_create(thing_blobs).map do |thing_blob|
      city_id = city_id_for_thing_blob(thing_blob)
      thing = Thing.unscoped.find_or_initialize_by(city_id: city_id)
      Rails.logger.info("Creating thing #{thing.city_id}")

      thing.update!(_thing_params(thing_blob))
      thing
    end
  end

  def self.load_things(source_url)
    Rails.logger.info('Downloading Things... ... ...')
    thing_blobs = _get_parsed_things_csv(source_url)
    Rails.logger.info("Downloaded #{thing_blobs.size} Things.")

    deleted_things_with_adoptee, deleted_things_no_adoptee = _delete_non_existing_things(thing_blobs)

    _update_things(thing_blobs)
    created_things = _create_things(thing_blobs)

    ThingMailer.thing_update_report(deleted_things_with_adoptee, deleted_things_no_adoptee, created_things).deliver_now
  end
end
