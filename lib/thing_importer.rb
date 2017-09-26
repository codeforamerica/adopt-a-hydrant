require 'open-uri'

# class for importing things from CSV datasource
# is currently very specific to drains from DataSF
#
# Dataset:
# https://data.sfgov.org/City-Infrastructure/Stormwater-inlets-drains-and-catch-basins/jtgq-b7c5
class ThingImporter
  class << self
    def load(source_url)
      Rails.logger.info('Downloading Things... ... ...')

      ActiveRecord::Base.transaction do
        import_temp_things(source_url)

        deleted_things_with_adoptee, deleted_things_no_adoptee = delete_non_existing_things
        created_things = upsert_things

        ThingMailer.thing_update_report(deleted_things_with_adoptee, deleted_things_no_adoptee, created_things).deliver_now
      end
    end

    def integer?(string)
      return true if string =~ /\A\d+\Z/

      false
    end

    def normalize_thing(csv_thing)
      (lat, lng) = csv_thing['Location'].delete('()').split(',').map(&:strip)
      {
        city_id: csv_thing['PUC_Maximo_Asset_ID'].gsub!('N-', ''),
        lat: lat,
        lng: lng,
        type: csv_thing['Drain_Type'],
        system_use_code: csv_thing['System_Use_Code'],
      }
    end

    def invalid_thing(thing)
      false unless ['Storm Water Inlet Drain', 'Catch Basin Drain'].include?(thing[:type])
      false unless integer?(thing[:city_id])
      true
    end

    # load all of the items into a temporary table, temp_thing_import
    def import_temp_things(source_url)
      insert_statement_id = SecureRandom.uuid

      conn = ActiveRecord::Base.connection
      conn.execute(<<-SQL.strip_heredoc)
        CREATE TEMPORARY TABLE "temp_thing_import" (
          id serial,
          name varchar,
          lat numeric(16,14),
          lng numeric(17,14),
          city_id integer,
          system_use_code varchar
        )
      SQL
      conn.raw_connection.prepare(insert_statement_id, 'INSERT INTO temp_thing_import (name, lat, lng, city_id, system_use_code) VALUES($1, $2, $3, $4, $5)')

      csv_string = open(source_url).read
      CSV.parse(csv_string, headers: true).
        map { |t| normalize_thing(t) }.
        select { |t| invalid_thing(t) }.
        each do |thing|
        conn.raw_connection.exec_prepared(
          insert_statement_id,
          [thing[:type], thing[:lat], thing[:lng], thing[:city_id], thing[:system_use_code]],
        )
      end

      conn.execute('CREATE INDEX "temp_thing_import_city_id" ON temp_thing_import(city_id)')
    end

    # mark drains as deleted that do not exist in the new set
    # return the deleted drains partitioned by whether they were adopted
    def delete_non_existing_things
      # mark deleted_at as this is what the paranoia gem uses to scope
      deleted_things = ActiveRecord::Base.connection.execute(<<-SQL.strip_heredoc)
        UPDATE things
        SET deleted_at = NOW()
        WHERE things.city_id NOT IN (SELECT city_id from temp_thing_import) AND deleted_at IS NULL
        RETURNING things.city_id, things.user_id
      SQL
      deleted_things.partition { |thing| thing['user_id'].present? }
    end

    def upsert_things
      # postgresql's RETURNING returns both updated and inserted records so we
      # query for the items to be inserted first
      created_things = ActiveRecord::Base.connection.execute(<<-SQL.strip_heredoc)
        SELECT temp_thing_import.city_id
        FROM things
        RIGHT JOIN temp_thing_import ON temp_thing_import.city_id = things.city_id
        WHERE things.id IS NULL
      SQL

      ActiveRecord::Base.connection.execute(<<-SQL.strip_heredoc)
        INSERT INTO things(name, lat, lng, city_id, system_use_code)
        SELECT name, lat, lng, city_id, system_use_code FROM temp_thing_import
        ON CONFLICT(city_id) DO UPDATE SET
          lat = EXCLUDED.lat,
          lng = EXCLUDED.lng,
          name = EXCLUDED.name,
          deleted_at = NULL
      SQL

      created_things
    end
  end
end
