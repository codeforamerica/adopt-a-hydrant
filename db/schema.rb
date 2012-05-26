# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120516004037) do

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reminders", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_user_id",                    :null => false
    t.integer  "to_user_id",                      :null => false
    t.integer  "thing_id",                        :null => false
    t.boolean  "sent",         :default => false
  end

  add_index "reminders", ["from_user_id"], :name => "index_reminders_on_from_user_id"
  add_index "reminders", ["sent"], :name => "index_reminders_on_sent"
  add_index "reminders", ["thing_id"], :name => "index_reminders_on_thing_id"
  add_index "reminders", ["to_user_id"], :name => "index_reminders_on_to_user_id"

  create_table "things", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.decimal  "lat",          :precision => 18, :scale => 14,                :null => false
    t.decimal  "lng",          :precision => 18, :scale => 14,                :null => false
    t.integer  "user_id"
    t.integer  "lock_version",                                 :default => 0, :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                                     :null => false
    t.string   "organization"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "voice_number"
    t.string   "sms_number"
    t.boolean  "admin",                                 :default => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "reminders", "things", :name => "reminders_thing_id_fk"
  add_foreign_key "reminders", "users", :name => "reminders_from_user_id_fk", :column => "from_user_id"
  add_foreign_key "reminders", "users", :name => "reminders_to_user_id_fk", :column => "to_user_id"

  add_foreign_key "things", "users", :name => "things_user_id_fk"
end