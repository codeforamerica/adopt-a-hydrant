class Reminder < ActiveRecord::Base
  validates_presence_of :from_user, :to_user, :hydrant
  belongs_to :from_user, :class_name => "User"
  belongs_to :to_user, :class_name => "User"
  belongs_to :hydrant
end
