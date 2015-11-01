namespace :data do
  require 'open-uri'
  require 'csv'

  task :load_drains => :environment do
    url = "https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD"
    csv_string = open(url).read
    drains = CSV.parse(csv_string, headers: true)

    drains.each do |drain|
      location = drain["Location"]
      location = location.gsub!("(", "")
      location = location.gsub!(")", "")
      latlng = location.split(",")
      lat = latlng[0].strip
      lng = latlng[1].strip

      p Thing.create!({
        name: drain["Drain_Type"],
        city_id: drain["PUC_Maximo_Asset_ID"],
        lat: lat,
        lng: lng
      })
    end
  end
end
