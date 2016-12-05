require 'test_helper'

class ThingMailerTest < ActionMailer::TestCase
  test 'first_adopted_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.first_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['info@sfwater.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'Thanks for adopting a drain, Erik! Here’s important info', email.subject
  end

  test 'second_adoption_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.second_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['info@sfwater.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'Thanks for adopting another drain, Erik!', email.subject
  end

  test 'third_adoption_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.third_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['info@sfwater.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'We really do love you, Erik!', email.subject
  end

  test 'drain_deleted_notification' do
    admin_1 = users(:admin)
    admin_2 = users(:admin)
    admin_2.update(email: 'admin2@example.com')
    thing = things(:thing_1)

    email = nil
    assert_emails(1) do
      email = ThingMailer.drain_deleted_notification(thing).deliver_now
    end

    assert_includes email.to, admin_1.email
    assert_includes email.to, admin_2.email

    assert_equal email.subject, 'A drain has been removed.'
  end
end
