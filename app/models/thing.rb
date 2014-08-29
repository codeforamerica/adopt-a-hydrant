require 'geokit'

class Thing < ActiveRecord::Base
  has_many  :users,     through: :adoptions
  has_many  :reminders, through: :adoptions
  validates :city_id, presence: true, uniqueness: true
  validates :city_unique_id, presence: true, uniqueness: true
  validates :lat, presence: true
  validates :lng, presence: true

  before_save :setLonLat

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

  private

  def setLonLat
    # note that these go LONGITUDE, LATITUDE (y,x)
    self.lonlat = "POINT(#{longitude} #{latitude})"
  end
end
