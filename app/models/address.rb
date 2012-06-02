class Address
  include Geokit::Geocoders

  def self.geocode(address)
    MultiGeocoder.geocode(address).ll.split(',').map{|s| s.to_f}
  end
end