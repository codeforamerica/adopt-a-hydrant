require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:from_user, :to_user] do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(8) }
  end
end
