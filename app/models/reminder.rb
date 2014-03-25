class Reminder < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  validates_presence_of :from_user, :to_user, :thing
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"
  belongs_to :thing
end
