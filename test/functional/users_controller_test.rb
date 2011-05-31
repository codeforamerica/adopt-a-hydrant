require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:erik)
  end

  test 'should render info window' do
    sign_in @user
    get :edit
    assert_response :success
    assert_select 'div#info_window', true
    assert_select 'form#edit_form' do
      assert_select '[action=?]', '/users'
      assert_select '[method=?]', 'post'
    end
    assert_select 'h2', 'Edit your Profile'
    assert_select 'input', :count => 14
    assert_select 'label', :count => 7
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Update'
    end
    assert_select 'form#back_form' do
      assert_select '[action=?]', '/info_window'
      assert_select '[method=?]', 'get'
    end
    assert_select 'input[name="commit"]' do
      assert_select '[type=?]', 'submit'
      assert_select '[value=?]', 'Back'
    end
  end

  test 'should update user if password is correct' do
    sign_in @user
    assert_not_equal @user.name, 'New Name'
    put :update, :user => {:name => 'New Name', :current_password => 'correct'}
    @user.reload
    assert_equal @user.name, 'New Name'
    assert_response :redirect
    assert_redirected_to :controller => 'info_window', :action => 'index'
  end

  test 'should return error if password is incorrect' do
    sign_in @user
    put :update, :user => {:name => 'New Name', :current_password => 'incorrect'}
    assert_response :error
  end

  test 'should create user if information is valid' do
    post :create, :user => {:email => 'user@example.com', :name => 'User', :password => 'correct', :password_confirmation => 'correct'}
    assert_response :success
  end

  test 'should return error if information is invalid' do
    post :create, :user => {:email => 'user@example.com', :name => 'User', :password => 'correct', :password_confirmation => 'incorrect'}
    assert_response :error
  end
end
