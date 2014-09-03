class Address
  include Geokit::Geocoders

  def self.geocode(address)
    MultiGeocoder.geocode(address).ll.split(',').collect(&:to_f)
  end
end
