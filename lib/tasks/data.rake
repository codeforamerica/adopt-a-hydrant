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

      name = drain['Drain_Type']
      city_id = drain['PUC_Maximo_Asset_ID']
      city_id.gsub!('N-', '') # Strip `N-` from the Asset ID
      location = drain['Location']
      location.delete!('(') # Cleanup brackets
      location.delete!(')')

      latlng = location.split(',')
      lat = latlng[0].strip
      lng = latlng[1].strip

      thing_hash = {
        name: name,
        city_id: city_id,
        lat: lat,
        lng: lng,
      }

      thing = Thing.create!(thing_hash)
      puts "Created Thing #{thing.id} - #{thing.name}"
    end
  end
end
