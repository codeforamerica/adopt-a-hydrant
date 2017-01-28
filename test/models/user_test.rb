require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'removing non digits from phone numbers' do
    user = users(:erik)
    user.sms_number = '1234croehu567890'
    user.voice_number = '109876oecruh4321'
    user.remove_non_digits_from_phone_numbers
    assert_equal '1234567890', user.sms_number
    assert_equal '1098764321', user.voice_number
  end

  test 'name' do
    user = users(:erik)
    assert_equal 'Erik Michaels-Ober', user.name
    user.last_name = ''
    assert_equal 'Erik', user.name
  end

  test 'last name is required for new users' do
    user = User.new(first_name: 'Erik')
    user.save
    assert_equal ["can't be blank"], user.errors[:last_name]
  end

  # requirement was added later
  test 'last name not required for existing users' do
    user = users(:erik)
    user.last_name = ''
    user.save!
    assert_equal [], user.errors[:last_name]
  end
end
