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

ActiveRecord::Schema.define(version: 20140410083926) do

  create_table "callers", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.boolean  "activation", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caller_id"
  end

  create_table "meetings", force: true do |t|
    t.integer  "caller_id"
    t.integer  "receiver_id"
    t.integer  "order_id"
    t.integer  "duration"
    t.integer  "call_type",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetings", ["caller_id"], name: "index_meetings_on_caller_id"
  add_index "meetings", ["receiver_id"], name: "index_meetings_on_receiver_id"

  create_table "receivers", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.boolean  "activation",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "receiver_id"
  end

end
