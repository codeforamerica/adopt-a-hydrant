namespace :data do
  require 'open-uri'
  require 'csv'

  task :load_drains => :environment do
    puts "Downloading Drains... ... ..."
    url = "https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD"
    csv_string = open(url).read
    drains = CSV.parse(csv_string, headers: true)
    puts "Downloaded #{drains.size} Drains."

    drains.each do |drain|
      if ["Storm Water Inlet Drain", "Catch Basin Drain"].include? drain["Drain_Type"]
        thing = Thing.create!(drain_to_thing_hash(drain: drain))
        puts "Created Thing #{thing.id} - #{thing.name}"
      end
    end
  end
end

def drain_to_thing_hash(drain:)
  name = drain["Drain_Type"]

  city_id = drain["PUC_Maximo_Asset_ID"]
  # Strip `N-` from the Asset ID
  city_id.gsub!("N-", "")

  location = drain["Location"]
  # Cleanup brackets
  location.gsub!("(", "")
  location.gsub!(")", "")

  latlng = location.split(",")
  lat = latlng[0].strip
  lng = latlng[1].strip

  {
    name: name,
    city_id: city_id,
    lat: lat,
    lng: lng
  }
end
