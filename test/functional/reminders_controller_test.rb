require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  setup do
    @thing = things(:thing_1)
    @dan = users(:dan)
    @erik = users(:erik)
    @thing.user = @dan
    @thing.save!
  end

  test 'should send a reminder email' do
    num_deliveries = ActionMailer::Base.deliveries.size
    post :create, :format => :json, :reminder => {:thing_id => @thing.id, :from_user_id => @erik.id, :to_user_id => @dan.id}
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
    assert_response :success
    email = ActionMailer::Base.deliveries.last
    assert_equal [@dan.email], email.to
    assert_equal "Remember to shovel", email.subject
  end
end
