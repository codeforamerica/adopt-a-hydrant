require 'geokit'

class Thing < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :user
  has_many :reminders
  validates :city_id, uniqueness: true, allow_nil: true
  validates :lat, presence: true
  validates :lng, presence: true

  def self.find_closest(lat, lng, limit = 10)
    query = <<-SQL
      SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance
      FROM things
      ORDER BY distance
      LIMIT ?
      SQL
    find_by_sql([query, lat.to_f, lng.to_f, lat.to_f, limit.to_i])
  end

  def reverse_geocode
    @reverse_geocode ||= Geokit::Geocoders::MultiGeocoder.reverse_geocode([lat, lng])
  end

  def street_number
    reverse_geocode.street_number
  end

  def street_name
    reverse_geocode.street_name
  end

  def street_address
    reverse_geocode.street_address
  end

  def city
    reverse_geocode.city
  end

  def state
    reverse_geocode.state
  end

  def zip
    reverse_geocode.zip
  end

  def country_code
    reverse_geocode.country_code
  end

  def country
    reverse_geocode.country
  end

  def full_address
    reverse_geocode.full_address
  end

  def adopted?
    !user.nil?
  end
end
