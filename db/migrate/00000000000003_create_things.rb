class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      # from the city data
      t.integer :city_id, index: true, unique: true
      t.string  :city_unique_id, index: true, unique: true
      t.decimal :lat, null: false, precision: 32, scale: 29
      t.decimal :lon, null: false, precision: 32, scale: 29
      t.string  :species
      # heap of everything
      t.json    :properties

      # PostGIS magic
      t.point   :lonlat, geographic: true, spatial: true, index: true

      t.timestamps
    end
  end
end
