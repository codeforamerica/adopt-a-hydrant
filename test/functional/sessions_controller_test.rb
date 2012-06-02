require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:erik)
  end

  test 'should redirect to root path' do
    get :new
    assert_response :redirect
  end

  test 'should redirect if user is already authenticated' do
    sign_in @user
    get :new
    assert_response :redirect
  end

  test 'should authenticate user if password is correct' do
    post :create, :user => {:email => @user.email, :password => 'correct'}
    assert_response :success
  end

  test 'should return error if password is incorrect' do
    post :create, :user => {:email => @user.email, :password => 'incorrect'}
    assert_response 401
  end

  test 'should empty session on sign out' do
    sign_in @user
    get :destroy
    assert_equal Hash.new, session
    assert_response :success
  end
end