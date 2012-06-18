class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable
  attr_accessible :address_1, :address_2, :city, :email, :name, :organization,
    :password, :password_confirmation, :remember_me, :sms_number, :state,
    :voice_number, :zip
  validates_formatting_of :email, using: :email
  validates_formatting_of :sms_number, using: :us_phone, allow_blank: true
  validates_formatting_of :voice_number, using: :us_phone, allow_blank: true
  validates_formatting_of :zip, using: :us_zip, allow_blank: true
  validates_presence_of :name
  has_many :reminders_to, class_name: "Reminder", foreign_key: "to_user_id"
  has_many :reminders_from, class_name: "Reminder", foreign_key: "from_user_id"
  has_many :things
  before_validation :remove_non_digits_from_phone_numbers
  def remove_non_digits_from_phone_numbers
    self.sms_number = self.sms_number.to_s.gsub(/\D/, '').to_i if self.sms_number.present?
    self.voice_number = self.voice_number.to_s.gsub(/\D/, '').to_i if self.voice_number.present?
  end
end
