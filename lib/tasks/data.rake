require 'rake'

namespace :data do
  task load_drains: :environment do
    Thing.load_drains('https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD')
  end
end
