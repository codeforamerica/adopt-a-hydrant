class Reminder < ActiveRecord::Base
  attr_accessible :thing_id, :to_user_id
  validates_presence_of :from_user, :to_user, :thing
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"
  belongs_to :thing
end
