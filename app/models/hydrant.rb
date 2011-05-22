class Hydrant < ActiveRecord::Base
  validates_presence_of :lat, :lng
  belongs_to :user
  has_many :reminders

  def self.find_closest(lat, lng, limit=50)
    query = <<-SQL
      SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(radians(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance
      FROM hydrants
      ORDER BY distance
      LIMIT ?
      SQL
    Hydrant.find_by_sql([query, lat.to_f, lng.to_f, lat.to_f, limit.to_i])
  end

  def adopted?
    !user.nil?
  end

end
