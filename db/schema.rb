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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141101172738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "promo_codes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "promo_vendor_id"
    t.string   "token"
    t.integer  "user_id"
  end

  add_index "promo_codes", ["promo_vendor_id"], name: "index_promo_codes_on_promo_vendor_id", using: :btree
  add_index "promo_codes", ["user_id"], name: "index_promo_codes_on_user_id", using: :btree

  create_table "promo_vendors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", force: true do |t|
    t.integer  "thing_id",                     null: false
    t.integer  "from_user_id",                 null: false
    t.integer  "to_user_id",                   null: false
    t.boolean  "sent",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "mpls_id"
    t.string   "mpls_unique"
    t.decimal  "lat",         precision: 32, scale: 29, null: false
    t.decimal  "lng",         precision: 32, scale: 29, null: false
    t.string   "species"
    t.json     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                                                        null: false
    t.string   "organization"
    t.string   "voice_number"
    t.string   "sms_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "admin",                                       default: false
    t.string   "email",                                       default: "",    null: false
    t.string   "encrypted_password",                          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "yob"
    t.string   "gender"
    t.string   "ethnicity",                       limit: nil,                              array: true
    t.integer  "yearsInMinneapolis"
    t.string   "rentOrOwn"
    t.boolean  "previousTreeWateringExperience"
    t.boolean  "previousEnvironmentalActivities"
    t.integer  "valueForestryWork"
    t.string   "heardOfAdoptATreeVia"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
