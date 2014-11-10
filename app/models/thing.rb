# == Schema Information
#
# Table name: things
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  user_id     :integer
#  mpls_id     :integer
#  mpls_unique :string(255)
#  lat         :decimal(32, 29)  not null
#  lng         :decimal(32, 29)  not null
#  species     :string(255)
#  properties  :json
#  created_at  :datetime
#  updated_at  :datetime
#

require 'geokit'

class Thing < ActiveRecord::Base
  extend Forwardable
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to  :user
  has_many    :reminders
  def_delegators :reverse_geocode, :city, :country, :country_code,
                 :full_address, :state, :street_address, :street_name,
                 :street_number, :zip

  validates :mpls_id,     uniqueness: true, allow_nil: true
  validates :mpls_unique, uniqueness: true, allow_nil: true
  validates :lat,         presence:   true
  validates :lng,         presence:   true

  def self.find_closest(lat, lng, limit = 10)
    query = <<-SQL
      SELECT *, (3959 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS distance
      FROM things
      ORDER BY distance
      LIMIT ?
      SQL
    find_by_sql([query, lat.to_f, lng.to_f, lat.to_f, limit.to_i])
  end

  def reverse_geocode
    @reverse_geocode ||= Geokit::Geocoders::MultiGeocoder.reverse_geocode([lat, lng])
  end

  def adopted?
    !user.nil?
  end
end
