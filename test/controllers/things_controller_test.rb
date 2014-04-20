require 'test_helper'

class ThingsControllerTest < ActionController::TestCase
  setup do
    @thing = things(:thing_1)
  end

  test 'should list hydrants' do
    get :show, format: 'json', lat: 42.358431, lng: -71.059773
    assert_not_nil assigns :things
    assert_response :success
  end

  test 'should update hydrant' do
    assert_not_equal 'Birdsill', @thing.name
    put :update, format: 'json', id: @thing.id, thing: {name: 'Birdsill'}
    @thing.reload
    assert_equal 'Birdsill', @thing.name
    assert_not_nil assigns :thing
    assert_response :success
  end
end
