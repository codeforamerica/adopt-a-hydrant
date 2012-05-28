class Thing < ActiveRecord::Base
  include Geokit::Geocoders
  require 'libxml'
  #validates_uniqueness_of :city_id, :allow_nil => true
  validates_presence_of :lat, :lng
  belongs_to :user
  has_many :reminders

  def self.find_closest(lat, lng, limit=10)
    query = <<-SQL
      SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance
      FROM things
      ORDER BY distance
      LIMIT ?
      SQL
    find_by_sql([query, lat.to_f, lng.to_f, lat.to_f, limit.to_i])
  end

  def reverse_geocode
    @reverse_geocode ||= MultiGeocoder.reverse_geocode([lat, lng])
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
    !user_id.nil?
  end
  
  def get_snow_amounts(nodes)
    snow_amounts = Array.new

    while nodes.read
      unless nodes.node_type == LibXML::XML::Reader::TYPE_END_ELEMENT
        if nodes.name == "value"
          nodes.read
          snow_amounts.push nodes.value
        end
      end
    end
    
    nodes.close
    return snow_amounts
  end
  
end