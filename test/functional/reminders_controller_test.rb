require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  setup do
    @hydrant = hydrants(:hydrant_1)
    @dan = users(:dan)
    @erik = users(:erik)
    @hydrant.user = @dan
    @hydrant.save!
  end

  test 'should send a reminder email' do
    num_deliveries = ActionMailer::Base.deliveries.size
    post :create, :format => :json, :reminder => {:hydrant_id => @hydrant.id, :from_user_id => @erik.id, :to_user_id => @dan.id}
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
    assert_response :success
    email = ActionMailer::Base.deliveries.last
    assert_equal [@dan.email], email.to
    assert_equal "Remember to Shovel", email.subject
  end
end
