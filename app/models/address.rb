class Address
  include Geokit::Geocoders

  def self.find_lat_lng(address)
    MultiGeocoder.geocode(address).ll.split(',').map{|s| s.to_f}
  end
end
