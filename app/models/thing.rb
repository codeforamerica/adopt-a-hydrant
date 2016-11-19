require 'open-uri'
require 'csv'

class Thing < ActiveRecord::Base
  extend Forwardable
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :user
  def_delegators :reverse_geocode, :city, :country, :country_code,
                 :full_address, :state, :street_address, :street_name,
                 :street_number, :zip
  has_many :reminders
  validates :city_id, uniqueness: true, allow_nil: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :name, obscenity: true

  scope :adopted, -> { where.not(user_id: nil) }

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

  # Link to more details about type of Thing
  #
  # Currently hardcoding since we only have one special case, but we should
  # move this into the database if we add an additional
  def detail_link
    return 'http://sfwater.org/index.aspx?page=399' if system_use_code == 'MS4'

    nil
  end

  def self.load_drains(source_url)
    puts 'Downloading Drains... ... ...'
    csv_string = open(source_url).read
    drains = CSV.parse(csv_string, headers: true)
    puts "Downloaded #{drains.size} Drains."

    city_ids = drains.map { |drain|
      drain["PUC_Maximo_Asset_ID"].gsub("N-", "")
    }

    Thing.where.not(city_id: city_ids).delete_all

    drains.each do |drain|
      next unless ['Storm Water Inlet Drain', 'Catch Basin Drain'].include?(drain['Drain_Type'])

      (lat, lng) = drain['Location'].delete('()').split(',').map(&:strip)

      thing_hash = {
        name: drain['Drain_Type'],
        system_use_code: drain['System_Use_Code'],
        lat: lat,
        lng: lng,
      }

      thing = Thing.where(city_id: drain['PUC_Maximo_Asset_ID'].gsub('N-', '')).first_or_initialize
      if thing.new_record?
        puts "Creating thing #{thing_hash[:city_id]}"
      else
        puts "Updating thing #{thing_hash[:city_id]}"
      end
      thing.update_attributes!(thing_hash)
    end
  end
end
