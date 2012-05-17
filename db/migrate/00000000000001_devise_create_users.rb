class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name, :null => false
      t.string :organization
      t.string :email, :null => false
      t.string :voice_number
      t.string :sms_number
      t.boolean :admin, :default => false
      # t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
    end

    add_index :users, :email, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end