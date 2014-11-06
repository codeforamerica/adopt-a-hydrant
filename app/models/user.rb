class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reminders_from, class_name: 'Reminder', foreign_key: 'from_user_id'
  has_many :reminders_to,   class_name: 'Reminder', foreign_key: 'to_user_id'
  has_many :things
  has_many :promo_codes

  before_validation :remove_non_digits_from_phone_numbers

  validates :name, presence: true
  validates_formatting_of :email,         using: :email
  validates_formatting_of :sms_number,    using: :us_phone, allow_blank: true
  validates_formatting_of :voice_number,  using: :us_phone, allow_blank: true
  validates_formatting_of :zip,           using: :us_zip, allow_blank: true

  def complete_shipping_address?
    shipping_attrs = ["name", "address_1", "city", "state", "zip"]
    shipping_attrs.none? {|attr_name| self.attributes[attr_name].blank?}
  end

  def used_code?
    not self.promo_codes.empty?
  end

  def remove_non_digits_from_phone_numbers
    if sms_number.present?
      self.sms_number = sms_number.to_s.gsub(/\D/, '').to_i
    end

    if voice_number.present?
      self.voice_number = voice_number.to_s.gsub(/\D/, '').to_i
    end
  end
end
