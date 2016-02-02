require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = users(:erik)
  end

  test 'should send password reset instructions if email address is found' do
    num_deliveries = ActionMailer::Base.deliveries.size
    post :create, user: {email: @user.email}
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
    assert_response :success
    email = ActionMailer::Base.deliveries.last
    assert_equal [@user.email], email.to
    assert_equal 'Adopt-a-drain San Francisco reset password instructions', email.subject
  end

  test 'should not send password reset instructions if email address is not found' do
    post :create, user: {email: 'not_found@example.com'}
    assert_response :error
  end

  test 'should redirect if signed in' do
    sign_in(@user)
    get :edit, reset_password_token: 'token'
    assert_redirected_to root_path
    assert_equal 'You are already signed in.', flash[:alert]
  end

  test 'should render edit view' do
    get :edit, reset_password_token: 'token'
    assert_response :success
    assert_template 'main/index'
    assert_not_nil assigns(:reset_password_token)
  end

  test 'should reset user password with an valid reset password token' do
    token = @user.send_reset_password_instructions
    put :update, user: {reset_password_token: token, password: 'new_password'}
    @user.reload
    assert @user.valid_password?('new_password')
    assert_response :success
  end

  test 'should not reset user password with an invalid reset password token' do
    @user.send_reset_password_instructions
    put :update, user: {reset_password_token: 'invalid_token', password: 'new_password'}
    @user.reload
    assert !@user.valid_password?('new_password')
    assert_response :error
    assert_equal ['is invalid'], JSON.parse(response.body)['errors']['reset_password_token']
  end
end
