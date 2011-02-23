class CreateHydrants < ActiveRecord::Migration
  def self.up
    create_table :hydrants do |t|
      t.timestamps
      t.decimal :lat
      t.decimal :lng
      t.integer :city_id
      t.integer :user_id
    end
    add_index :hydrants, :city_id, :unique => true
  end

  def self.down
    drop_table :hydrants
  end
end
