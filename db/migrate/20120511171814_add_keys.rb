class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "reminders", "users", :name => "reminders_from_user_id_fk", :column => "from_user_id"
    add_foreign_key "reminders", "things", :name => "reminders_thing_id_fk"
    add_foreign_key "reminders", "users", :name => "reminders_to_user_id_fk", :column => "to_user_id"
    add_foreign_key "things", "users", :name => "things_user_id_fk"
  end
end
