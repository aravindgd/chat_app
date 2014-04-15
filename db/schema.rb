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

ActiveRecord::Schema.define(version: 20140415081921) do

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.string   "app_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.integer  "caller_id"
    t.integer  "receiver_id"
    t.integer  "api_key_id"
    t.integer  "order_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pin"
    t.time     "start_time"
    t.date     "start_date"
  end

  add_index "meetings", ["api_key_id"], name: "index_meetings_on_api_key_id"
  add_index "meetings", ["caller_id"], name: "index_meetings_on_caller_id"
  add_index "meetings", ["receiver_id"], name: "index_meetings_on_receiver_id"

  create_table "users", force: true do |t|
    t.string   "uniq_id"
    t.string   "name"
    t.integer  "number"
    t.integer  "api_key_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["api_key_id"], name: "index_users_on_api_key_id"

end
