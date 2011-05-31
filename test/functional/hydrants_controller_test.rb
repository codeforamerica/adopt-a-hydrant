require 'test_helper'

class HydrantsControllerTest < ActionController::TestCase
  setup do
    @hydrant = hydrants(:hydrant_1)
  end

  # test 'should list hydrants' do
  #   skip 'Cannot test query on sqlite3 test database'
  #   get :show, :format => 'json', :lat => 42.358431, :lng => -71.059773
  #   assert_not_nil assigns :hydrants
  #   assert_response :success
  # end

  test 'should update hydrant' do
    assert_not_equal 'Birdsill', @hydrant.name
    put :update, :format => 'json', :id => @hydrant.id, :hydrant => {:name => 'Birdsill'}
    @hydrant.reload
    assert_equal 'Birdsill', @hydrant.name
    assert_not_nil assigns :hydrant
    assert_response :success
  end
end
