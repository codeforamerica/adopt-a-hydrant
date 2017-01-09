require 'rake'

namespace :data do
  task load_things: :environment do
    Thing.load_things('https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD')
  end
end
