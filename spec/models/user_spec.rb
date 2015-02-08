# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  first_name                      :string(255)      
#  last_name                       :string(255)      
#  organization                    :string(255)
#  voice_number                    :string(255)
#  sms_number                      :string(255)
#  address_1                       :string(255)
#  address_2                       :string(255)
#  city                            :string(255)
#  state                           :string(255)
#  zip                             :string(255)
#  admin                           :boolean          default(FALSE)
#  email                           :string(255)      default(""), not null
#  encrypted_password              :string(255)      default(""), not null
#  reset_password_token            :string(255)
#  reset_password_sent_at          :datetime
#  remember_created_at             :datetime
#  sign_in_count                   :integer          default(0), not null
#  current_sign_in_at              :datetime
#  last_sign_in_at                 :datetime
#  current_sign_in_ip              :inet
#  last_sign_in_ip                 :inet
#  created_at                      :datetime
#  updated_at                      :datetime
#  yob                             :integer
#  gender                          :string(255)
#  ethnicity                       :string           is an Array
#  yearsInMinneapolis              :integer
#  rentOrOwn                       :string(255)
#  previousTreeWateringExperience  :boolean
#  previousEnvironmentalActivities :boolean
#  valueForestryWork               :integer
#  heardOfAdoptATreeVia            :string           is an Array
#  awareness_code                  :string(255)
#

require 'rails_helper'
require 'faker'

RSpec.describe User, :type => :model do
  it "is valid with a name, email and password" do
    user = build(:user)

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, username: nil)

    expect(user).to_not be_valid
    expect(user.errors[:username].count).to eq 1
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

  context "first and last names are set" do
    before(:each) { @user =  build(:modified_profile_user) }

    it "has accessible first and last names" do
      expect(@user.first_name).to_not be_blank
      expect(@user.last_name).to_not be_blank
    end

    it "has a full name" do
      expect(@user.full_name).to_not be_blank
      expect(@user.full_name).to eq("#{@user.first_name} #{@user.last_name}")
    end

  end

  context "complete_shipping_address?" do
    before(:each) do
      @user_attrs = {
          "first_name" => Faker::Name.first_name,
          "last_name" => Faker::Name.last_name,
          "address_1" => Faker::Address.street_address, 
          "city" => Faker::Address.city, 
          "state" => Faker::Address.state_abbr, 
          "zip" => Faker::Address.zip
      }
      @user = build(:user, @user_attrs) 
    end

    it "is true if required fields are complete" do
      expect(@user.complete_shipping_address?).to be true
    end

    it "is false if required fields are not complete" do
      @user_attrs.each do |attr_name, attr_value|
        @user.send("#{attr_name}=", '')
        expect(@user.complete_shipping_address?).to be false
        @user.send("#{attr_name}=", attr_value)
      end
    end
  end

  context "used_code?" do
    before(:each){ @user = build(:user) }

    it "is true if the User has a Promo Code" do
      promo_code = build(:promo_code)
      @user.promo_codes << promo_code

      expect(@user.used_code?).to be true
    end

    it "is false if the User does not have a Promo Code" do
      expect(@user.used_code?).to be false
    end
  end
end
