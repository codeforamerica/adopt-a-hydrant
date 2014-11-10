# == Schema Information
#
# Table name: promo_codes
#
#  id              :integer          not null, primary key
#  created_at      :datetime
#  updated_at      :datetime
#  promo_vendor_id :integer
#  token           :string(255)
#  user_id         :integer
#

FactoryGirl.define do
  factory :promo_code do
    token "MyString"
    promo_vendor
  end
end
