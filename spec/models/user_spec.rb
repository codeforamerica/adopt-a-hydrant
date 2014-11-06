require 'rails_helper'
require 'faker'

RSpec.describe User, :type => :model do
  it "is valid with a name, email and password" do
    user = build(:user)

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)

    expect(user).to_not be_valid
    expect(user.errors[:name].count).to eq 1
  end

  it "is invalide with an invalid email" do
    user = build(:user, email: 'invalid@example')

    expect(user).to_not be_valid
    expect(user.errors[:email].count).to eq 1
  end

  it "is invalide without an email" do
    user = build(:user, email: nil)

    expect(user).to_not be_valid
    expect(user.errors[:email].count).to eq 2
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end

  it "is invalid with a password length of 7" do
    user = build(:user, password: 'aaaaaaa')

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end
    
  it "is invalid with a password length of 129" do
    user = build(:user, password: 'a' * 129)

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end

  it "removes non-digits from voice number" do
    user = build(:user, voice_number: '555-555-5555')

    expect(user).to be_valid
    expect(user.voice_number).to eq 5555555555
  end

  it "removes non-digits from sms number" do
    user = build(:user, sms_number: '(555) 555-5555')

    expect(user).to be_valid
    expect(user.sms_number).to eq 5555555555
  end

  it "is invalid with an invalid sms number" do
    user = build(:user, sms_number: '1-555-555-5555')

    expect(user).to_not be_valid
    expect(user.errors[:sms_number].count).to eq 1
  end

  it "is invalid with an invalid voice number" do
    user = build(:user, voice_number: '1-555-555-5555')

    expect(user).to_not be_valid
    expect(user.errors[:voice_number].count).to eq 1
  end

  it "has a true complete_shipping_address? attribute if required fields are complete" do
    user = build(:user, 
        address_1: Faker::Address.street_address, 
        city: Faker::Address.city, 
        state: Faker::Address.state_abbr, 
        zip: Faker::Address.zip)

    expect(user.complete_shipping_address?).to be true
  end

  it "has a false complete_shipping_address? attribute if required fields are not complete" do
    user_attrs = {
        "address_1" => Faker::Address.street_address, 
        "city" => Faker::Address.city, 
        "state" => Faker::Address.state_abbr, 
        "zip" => Faker::Address.zip
    }
    user = build(:user, user_attrs) 
    user_attrs.each do |attr_name, attr_value|
      user.send("#{attr_name}=", '')
      expect(user.complete_shipping_address?).to be false
      user.send("#{attr_name}=", attr_value)
    end
  end

  it "has a true used_code? attribute if the User has a Promo Code" do
    user = build(:user)
    promo_code = build(:promo_code)
    user.promo_codes << promo_code

    expect(user.used_code?).to be true
  end

  it "has a false used_code? attribute if the User does not have a Promo Code" do
    user = build(:user)

    expect(user.used_code?).to be false
  end

end
