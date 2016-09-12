require 'test_helper'

class ThingsControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers

  setup do
    @thing = things(:thing_1)
    @request.env['devise.mapping'] = Devise.mappings[:admin]
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

  test 'should return hydrants belonging to user' do
    @thing2 = things(:thing_2)
    @user = users(:erik)
    sign_in @user
    put :update, format: 'json', id: @thing.id, thing: {user_id: @user.id}
    put :update, format: 'json', id: @thing2.id, thing: {user_id: @user.id}
    @thing.reload
    @thing2.reload
    get :show, format: 'json', user_id: @user.id
    assert_response :success
    assert_equal JSON.parse(@response.body).to_a.length, 2
    assert_includes(@response.body, @thing.to_json)
    assert_includes(@response.body, @thing2.to_json)

  end
end
