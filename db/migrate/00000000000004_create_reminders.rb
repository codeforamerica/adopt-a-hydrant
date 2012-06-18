class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.timestamps
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.integer :thing_id, null: false
      t.boolean :sent, default: false
    end

    add_index :reminders, :from_user_id
    add_index :reminders, :to_user_id
    add_index :reminders, :thing_id
    add_index :reminders, :sent
  end
end
