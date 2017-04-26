require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:erik)
  end

  test 'login with remembering' do
    post '/users/sign_in.json', user: {email: @user.email, password: 'correct', remember_me: 1}, format: :json
    assert_not_empty cookies['remember_user_token']
  end

  test 'login without remembering' do
    post '/users/sign_in.json', user: {email: @user.email, password: 'correct', remember_me: 1}, format: :json
    delete '/users/sign_out.json', format: :json
    post '/users/sign_in.json', user: {email: @user.email, password: 'correct', remember_me: 0}, format: :json
    assert_empty cookies['remember_user_token']
  end
end
