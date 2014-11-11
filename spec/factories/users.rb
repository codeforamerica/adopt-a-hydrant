# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  name                            :string(255)      not null
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

require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:from_user, :to_user] do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(8) }

    factory :modified_profile_user do
      address_1 { Faker::Address.street_address }
      address_2 { Faker::Address.secondary_address }
      city { Faker::Address.city }
      state { Faker::Address.state_abbr }
      zip { Faker::Address.zip_code }
      yob { 1900 + rand(100) }
      gender { rand(2) == 0 ? 'male' : 'female' }
      ethnicity { [rand(2) == 0 ? 'caucasian' : 'other'] }
      yearsInMinneapolis { rand(50) }
      rentOrOwn { rand(2) == 0 ? 'rent' : 'own' }
      previousTreeWateringExperience { rand(2) == 0 ? false : true }
      previousEnvironmentalActivities { rand(2) == 0 ? false : true }
      valueForestryWork { rand(9) + 1 }
      heardOfAdoptATreeVia { ['other'] }
    end
  end

end
