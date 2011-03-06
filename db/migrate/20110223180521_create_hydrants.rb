class CreateHydrants < ActiveRecord::Migration
  def self.up
    create_table :hydrants do |t|
      t.timestamps
      t.string :name
      t.decimal :lat, :null => false
      t.decimal :lng, :null => false
      t.integer :city_id
      t.integer :user_id
    end
    add_index :hydrants, :city_id, :unique => true
  end

  def self.down
    drop_table :hydrants
  end
end
