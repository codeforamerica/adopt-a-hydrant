# frozen_string_literal: true

require 'rake'

namespace :data do
  task load_things: :environment do
    require 'thing_importer'

    ThingImporter.load('https://data.sfgov.org/api/views/jtgq-b7c5/rows.csv?accessType=DOWNLOAD')
  end

  # move adoptions to closeby things
  # useful for rectifying adoptions of inconsistencies in the dataset (things
  # that are removed during scheduled import)
  task move_close_deleted_adoptions: :environment do
    require 'adoption_mover'

    ENV['ADOPTION_DELETION_FROM'] || raise('$ADOPTION_DELETION_FROM required')
    ENV['MAXIMUM_MOVEMENT_IN_FEET'] || raise('$MAXIMUM_MOVEMENT_IN_FEET required')

    adoption_deletion_from = Time.zone.parse(ENV['ADOPTION_DELETION_FROM'])

    moved_adoptions = AdoptionMover.move_close_deleted_adoptions(adoption_deletion_from, ENV['MAXIMUM_MOVEMENT_IN_FEET'])

    CSV($stdout) do |csv|
      csv << %w[from to]
      moved_adoptions.each do |from, to|
        csv << [from, to]
      end
    end
  end

  task fetch_adopter_info: :environment do
    ENV['CITY_IDS'] || raise('$CITY_IDS required')

    ids = ENV['CITY_IDS'].split(' ').map { |id| id.gsub!('N-', '') }

    Thing.unscoped.where(city_id: ids).each do |thing|
      puts "N-#{thing.city_id} named '#{thing.display_name}' at #{thing.reverse_geocode.formatted_address} adopted by #{thing.user.name}, #{thing.user.email}"
    end
  end
end
