require 'test_helper'

class SidebarControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = users(:erik)
  end

  # required by application.js to get the current user
  test 'search form should include current user id' do
    sign_in @user
    get :search
    assert_select '#current_user_id[value=?]', @user.id.to_s
  end
end
