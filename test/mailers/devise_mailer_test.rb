require 'test_helper'

class DeviseMailerTest < ActionMailer::TestCase
  test 'reset_password_instructions' do
    @user = users(:erik)

    email = DeviseMailer.reset_password_instructions(@user, '1234').deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['no-reply@sfwater.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'Adopt-a-drain San Francisco reset password instructions', email.subject
  end
end
