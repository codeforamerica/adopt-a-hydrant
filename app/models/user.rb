class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable
  before_validation :remove_non_digits_from_phone_numbers
  has_many :reminders_from, class_name: 'Reminder', foreign_key: 'from_user_id'
  has_many :reminders_to, class_name: 'Reminder', foreign_key: 'to_user_id'
  has_many :things
  validates :name, presence: true
  validates_formatting_of :email, using: :email
  validates_formatting_of :sms_number, using: :us_phone, allow_blank: true
  validates_formatting_of :voice_number, using: :us_phone, allow_blank: true
  validates_formatting_of :zip, using: :us_zip, allow_blank: true

  def remove_non_digits_from_phone_numbers
    self.sms_number = sms_number.to_s.gsub(/\D/, '').to_i if sms_number.present?
    self.voice_number = voice_number.to_s.gsub(/\D/, '').to_i if voice_number.present?
  end
end
