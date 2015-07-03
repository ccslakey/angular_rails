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

ActiveRecord::Schema.define(version: 20150703211503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "simple_receipts", force: :cascade do |t|
    t.integer  "store_owner_id"
    t.decimal  "total"
    t.decimal  "amount"
    t.decimal  "tip"
    t.string   "transaction_num"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "simple_receipts", ["store_owner_id"], name: "index_simple_receipts_on_store_owner_id", using: :btree

  create_table "store_owners", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "api_token"
  end

  add_index "store_owners", ["api_token"], name: "index_store_owners_on_api_token", unique: true, using: :btree

  add_foreign_key "simple_receipts", "store_owners"
end
