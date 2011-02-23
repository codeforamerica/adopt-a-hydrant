class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.timestamps
      t.string :name
      t.integer :voice_number
      t.integer :sms_number
      t.string :email
    end
  end

  def self.down
    drop_table :users
  end
end
