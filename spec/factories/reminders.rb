# == Schema Information
#
# Table name: reminders
#
#  id           :integer          not null, primary key
#  thing_id     :integer          not null
#  from_user_id :integer          not null
#  to_user_id   :integer          not null
#  sent         :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :reminder do
    thing
    from_user
    to_user
  end
end
