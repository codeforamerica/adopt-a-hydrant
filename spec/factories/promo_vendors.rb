# == Schema Information
#
# Table name: promo_vendors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :promo_vendor do
    name "MyString"
  end
end
