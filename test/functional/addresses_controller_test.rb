require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  test 'should return latitude and longitude for a valid address' do
    stub_request(:get, 'http://maps.google.com/maps/geo?q=City+Hall%2C+Boston%2C+MA&output=xml&key=REPLACE_WITH_YOUR_GOOGLE_KEY&oe=utf-8').
      to_return(:body => File.read(File.expand_path('../../fixtures/city_hall.kml', __FILE__)), :status => 200)
    get :show, :address => 'City Hall', :city_state => "Boston, MA"
    assert_not_nil assigns :address
  end

  test 'should return an error for an invalid address' do
    stub_request(:get, 'http://maps.google.com/maps/geo?q=%2C+&output=xml&key=REPLACE_WITH_YOUR_GOOGLE_KEY&oe=utf-8').
      to_return(:body => File.read(File.expand_path('../../fixtures/unknown_address.kml', __FILE__)), :status => 200)
    stub_request(:get, 'http://geocoder.us/service/csv/geocode?address=%2C+').
      to_return(:body => '', :status => 204)
    get :show, :address => '', :city_state => ''
    assert_response :missing
  end
end
