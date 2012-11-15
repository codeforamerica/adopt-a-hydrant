require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @thing = things(:thing_1)
    @dan = users(:dan)
    @user = users(:erik)
    @thing.user = @dan
    @thing.save!
    stub_request(:get, "http://maps.google.com/maps/geo").
      with(:query => {:key => "REPLACE_WITH_YOUR_GOOGLE_KEY", :ll => "42.383339,-71.049226", :oe => "utf-8", :output => "xml"}).
      to_return(body: File.read(File.expand_path('../../fixtures/geo.kml', __FILE__)))
  end

  test 'should send a reminder email' do
    sign_in @user
    num_deliveries = ActionMailer::Base.deliveries.size
    post :create, format: :json, reminder: {thing_id: @thing.id, to_user_id: @dan.id}
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
    assert_response :success
    email = ActionMailer::Base.deliveries.last
    assert_equal [@dan.email], email.to
    assert_equal 'Remember to shovel', email.subject
  end
end
