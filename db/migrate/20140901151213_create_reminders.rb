class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :thing_id,      null: false,    index: true
      t.integer :from_user_id,  null: false,    index: true
      t.integer :to_user_id,    null: false,    index: true
      t.boolean :sent,          default: false

      t.timestamps
    end
  end
end
