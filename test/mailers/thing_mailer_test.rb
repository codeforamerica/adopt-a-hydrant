require 'test_helper'

class ThingMailerTest < ActionMailer::TestCase
  test 'first_adopted_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.first_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['adoptadrain@codeforsanfrancisco.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'Thanks for adopting a drain, Erik! Here’s important info', email.subject
  end

  test 'second_adoption_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.second_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['adoptadrain@codeforsanfrancisco.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal "You're a drain-tastic person, Erik!", email.subject
  end

  test 'third_adoption_confirmation' do
    @user = users(:erik)
    @thing = things(:thing_1)
    @thing.user = @user

    email = ThingMailer.third_adoption_confirmation(@thing).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['adoptadrain@codeforsanfrancisco.org'], email.from
    assert_equal ['erik@example.com'], email.to
    assert_equal 'We really do love you, Erik!', email.subject
  end
end
