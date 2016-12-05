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

  def self._get_parsed_drains_csv(source_url)
    csv_string = open(source_url).read
    CSV.parse(csv_string, headers: true)
  end

  def self._delete_non_existing_drains(drains_from_source)
    city_ids = drains_from_source.map do |drain|
      drain['PUC_Maximo_Asset_ID'].gsub('N-', '')
    end

    Thing.where.not(city_id: city_ids).find_each do |thing|
      thing.destroy!
      ThingMailer.drain_deleted_notification(thing).deliver_now
    end
  end

  def self._drain_params(drain)
    (lat, lng) = drain['Location'].delete('()').split(',').map(&:strip)
    {
      name: drain['Drain_Type'],
      system_use_code: drain['System_Use_Code'],
      lat: lat,
      lng: lng,
    }
  end

  def self._create_or_update_drain(drain)
    city_id = drain['PUC_Maximo_Asset_ID'].gsub('N-', '')
    thing = Thing.where(city_id: city_id).first_or_initialize
    if thing.new_record?
      Rails.logger.info("Creating thing #{city_id}")
    else
      Rails.logger.info("Updating thing #{city_id}")
    end
    thing.update_attributes!(_drain_params(drain))
  end

  def self.load_drains(source_url)
    Rails.logger.info('Downloading Drains... ... ...')
    drains = _get_parsed_drains_csv(source_url)
    Rails.logger.info("Downloaded #{drains.size} Drains.")

    _delete_non_existing_drains(drains)

    drains.each do |drain|
      next unless VALID_DRAIN_TYPES.include?(drain['Drain_Type'])
      _create_or_update_drain(drain)
    end
  end
end
