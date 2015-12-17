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
end
