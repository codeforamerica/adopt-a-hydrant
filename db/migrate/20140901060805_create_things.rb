class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string  :name
      t.integer :user_id

      # from the city data
      t.integer :mpls_id,     unique: true
      t.string  :mpls_unique, unique: true
      t.decimal :lat,         null:   false,  precision: 32, scale: 29
      t.decimal :lng,         null:   false,  precision: 32, scale: 29
      t.string  :species
      # key:value store of all properties from city data
      t.json    :properties

      t.timestamps
    end
  end
end
