class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name, null: false
      t.string :organization
      t.string :email, null: false
      t.string :voice_number
      t.string :sms_number
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :admin, default: false
    end

    add_index :users, :email, unique: true
  end
end
