class Reminder < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to  :thing
  belongs_to  :from_user, class_name: 'User'
  belongs_to  :to_user,   class_name: 'User'
  validates   :thing,     presence:   true
  validates   :from_user, presence:   true
  validates   :to_user,   presence:   true
end
