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

class Reminder < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to  :thing
  belongs_to  :from_user, class_name: 'User'
  belongs_to  :to_user,   class_name: 'User'
  validates   :thing,     presence:   true
  validates   :from_user, presence:   true
  validates   :to_user,   presence:   true
end
