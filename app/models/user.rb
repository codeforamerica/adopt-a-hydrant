class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :name, :organization, :voice_number, :sms_number, :password, :password_confirmation, :remember_me
  validates_presence_of :name
  has_many :reminders_to, :class_name => "Reminder", :foreign_key => "to_user_id"
  has_many :reminders_from, :class_name => "Reminder", :foreign_key => "from_user_id"
  has_many :things
end
