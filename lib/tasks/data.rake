require 'rake'

namespace :data do
  require 'open-uri'
  require 'csv'

  task load_drains: :environment do
    puts 'Downloading Drains... ... ...'
    url = 'https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD'
    csv_string = open(url).read
    drains = CSV.parse(csv_string, headers: true)
    puts "Downloaded #{drains.size} Drains."

    drains.each do |drain|
      next unless ['Storm Water Inlet Drain', 'Catch Basin Drain'].include?(drain['Drain_Type'])

      (lat, lng) = drain['Location'].delete('()').split(',').map(&:strip)

      thing_hash = {
        name: drain['Drain_Type'],
        system_use_code: drain['System_Use_Code'],
        lat: lat,
        lng: lng,
      }

      thing = Thing.where(city_id: drain['PUC_Maximo_Asset_ID'].gsub!('N-', '')).first_or_initialize
      if thing.new_record?
        puts "Updating thing #{thing_hash[:city_id]}"
      else
        puts "Creating thing #{thing_hash[:city_id]}"
      end

      thing.update_attributes!(thing_hash)
    end
  end
end
