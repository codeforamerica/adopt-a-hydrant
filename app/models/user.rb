# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  first_name                      :string(255)      
#  last_name                       :string(255)      
#  organization                    :string(255)
#  voice_number                    :string(255)
#  sms_number                      :string(255)
#  address_1                       :string(255)
#  address_2                       :string(255)
#  city                            :string(255)
#  state                           :string(255)
#  zip                             :string(255)
#  admin                           :boolean          default(FALSE)
#  email                           :string(255)      default(""), not null
#  encrypted_password              :string(255)      default(""), not null
#  reset_password_token            :string(255)
#  reset_password_sent_at          :datetime
#  remember_created_at             :datetime
#  sign_in_count                   :integer          default(0), not null
#  current_sign_in_at              :datetime
#  last_sign_in_at                 :datetime
#  current_sign_in_ip              :inet
#  last_sign_in_ip                 :inet
#  created_at                      :datetime
#  updated_at                      :datetime
#  yob                             :integer
#  gender                          :string(255)
#  ethnicity                       :string           is an Array
#  yearsInMinneapolis              :integer
#  rentOrOwn                       :string(255)
#  previousTreeWateringExperience  :boolean
#  previousEnvironmentalActivities :boolean
#  valueForestryWork               :integer
#  heardOfAdoptATreeVia            :string           is an Array
#  awareness_code                  :string(255)
#

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

  validates :username, presence: true, uniqueness: true
  validates_formatting_of :email,         using: :email
  validates_formatting_of :sms_number,    using: :us_phone, allow_blank: true
  validates_formatting_of :voice_number,  using: :us_phone, allow_blank: true
  validates_formatting_of :zip,           using: :us_zip, allow_blank: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def complete_shipping_address?
    shipping_attrs = ["first_name", "last_name", "address_1", "city", "state", "zip"]
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
