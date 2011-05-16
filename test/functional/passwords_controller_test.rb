require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:erik)
  end

  test 'should send password reset instructions if email address is found' do
    num_deliveries = ActionMailer::Base.deliveries.size
    post :create, :user => {:email => @user.email}
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
    assert_response :success

    email = ActionMailer::Base.deliveries.last
    assert_equal [@user.email], email.to
    assert_equal "Reset password instructions", email.subject
    assert_match /Hello #{@user.email}!/, email.encoded
    assert_match /Someone has requested a link to change your password, and you can do this through the link below./, email.encoded
    assert_match /Change my password/, email.encoded
    assert_match /If you didn't request this, please ignore this email./, email.encoded
    assert_match /Your password won't change until you access the link above and create a new one./, email.encoded
  end

  test 'should not send password reset instructions if email address is not found' do
    post :create, :user => {:email => 'not_found@example.com'}
    assert_response :error
  end

  test 'should render edit view' do
    # skip 'Password reset not yet implemented'
    # get :edit, :reset_password_token => 'token'
    # assert_response :success
  end

  test 'should reset user password with an valid reset password token' do
    old_password = @user.password
    @user.send :generate_reset_password_token!
    put :update, :user => {:reset_password_token => @user.reset_password_token, :password => 'new_password', :password_confirmation => 'new_password'}
    @user.reload
    assert !@user.valid_password?(old_password)
    assert @user.valid_password?('new_password')
    assert_response :success
  end

  test 'should not reset user password with an invalid reset password token' do
    put :update, :user => {:reset_password_token => 'invalid_token', :password => 'new_password', :password_confirmation => 'new_password'}
    assert_response :error
  end
end
