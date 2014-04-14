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

ActiveRecord::Schema.define(version: 20140411134203) do

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "callers", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.boolean  "activation", default: true
    t.string   "call_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caller_id"
    t.integer  "user_id"
  end

  add_index "callers", ["user_id"], name: "index_callers_on_user_id"

  create_table "meetings", force: true do |t|
    t.integer  "caller_id"
    t.integer  "receiver_id"
    t.integer  "order_id"
    t.integer  "duration"
    t.integer  "call_type",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pin"
    t.time     "start_time"
    t.date     "start_date"
  end

  add_index "meetings", ["caller_id"], name: "index_meetings_on_caller_id"
  add_index "meetings", ["receiver_id"], name: "index_meetings_on_receiver_id"

  create_table "receivers", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.boolean  "activation",  default: true
    t.string   "call_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "receiver_id"
    t.integer  "user_id"
  end

  add_index "receivers", ["user_id"], name: "index_receivers_on_user_id"

  create_table "users", force: true do |t|
    t.string   "external_caller_id"
    t.string   "external_receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
