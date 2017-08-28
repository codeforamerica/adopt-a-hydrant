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
    assert_equal 'Thanks for adopting a drain, Erik!', email.subject
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

  test 'thing_update_report' do
    admin1 = users(:admin)
    admin2 = users(:admin)
    admin2.update(email: 'admin2@example.com')
    email = nil
    deleted_thing = things(:thing_1)

    assert_emails(1) do
      email = ThingMailer.thing_update_report([deleted_thing], [], []).deliver_now
    end

    assert_includes email.to, admin1.email
    assert_includes email.to, admin2.email

    assert_equal email.subject, 'Adopt-a-Drain San Francisco import (1 adopted drains removed, 0 drains added, 0 unadopted drains removed)'
  end
end
