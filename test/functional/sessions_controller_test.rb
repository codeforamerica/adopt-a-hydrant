require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'should render combo form' do
    get :new
    assert_response :success
    assert_select 'form' do
      assert_select '[action=?]', '/users/sign_in'
      assert_select '[method=?]', 'post'
    end
    assert_select 'h2', 'Adopt this Hydrant'
    assert_select 'input', :count => 15
    assert_select 'label', :count => 10
  end

  test 'should authenticate user if password is correct' do
    post :create, :user => {:email => 'user@example.com', :password => 'correct'}
    assert_response :success
  end

  test 'should return error if password is incorrect' do
    post :create, :user => {:email => 'user@example.com', :password => 'incorrect'}
    assert_response 401
  end

  test 'should empty session on sign out' do
    get :destroy
    assert_equal Hash.new, session
    assert_response :success
  end
end
