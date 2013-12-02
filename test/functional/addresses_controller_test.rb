require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  test 'should return latitude and longitude for a valid address' do
    stub_request(:get, "http://maps.google.com/maps/geo").
      with(:query => {:key => "REPLACE_WITH_YOUR_GOOGLE_KEY", :oe => "utf-8", :output => "xml", :q => "City Hall, Boston, MA"}).
      to_return(:body => File.read(File.expand_path('../../fixtures/city_hall.kml', __FILE__)))
    get :show, :address => 'City Hall', :city_state => "Boston, MA", :format => 'json'
    assert_not_nil assigns :address
  end

  test 'should return an error for an invalid address' do
    stub_request(:get, "http://geocoder.us/service/csv/geocode").
      with(:query => {:address => ", "}).
      to_return(:body => File.read(File.expand_path('../../fixtures/unknown_address.txt', __FILE__)))
    stub_request(:get, "http://maps.google.com/maps/geo").
      with(:query => {:key => "REPLACE_WITH_YOUR_GOOGLE_KEY", :oe => "utf-8", :output => "xml", :q => ", "}).
      to_return(:body => File.read(File.expand_path('../../fixtures/unknown_address.kml', __FILE__)))
    get :show, :address => '', :city_state => '', :format => 'json'
    assert_response :missing
  end
end
