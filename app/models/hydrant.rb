class Hydrant < ActiveRecord::Base
  belongs_to :user

  def self.find_closest(lat, lng, limit=100)
    Hydrant.find_by_sql(["SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(radians(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance FROM hydrants ORDER BY distance LIMIT ?", lat, lng, lat, limit])
  end

  def adopted?
    !user.nil?
  end

end
