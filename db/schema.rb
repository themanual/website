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

ActiveRecord::Schema.define(version: 20140203165406) do

  create_table "authors", force: true do |t|
    t.string   "name",       limit: 128, default: "", null: false
    t.string   "bio",        limit: 512, default: "", null: false
    t.string   "slug",       limit: 128, default: "", null: false
    t.string   "twitter",    limit: 32,  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_addresses", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "primary",    default: false, null: false
  end

  add_index "email_addresses", ["email"], name: "index_email_addresses_on_email", unique: true

  create_table "issues", force: true do |t|
    t.integer  "number",     default: 1, null: false
    t.integer  "volume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pieces", force: true do |t|
    t.string   "type",        limit: 32,   default: "Article", null: false
    t.integer  "author_id"
    t.integer  "issue_id"
    t.string   "title",       limit: 256,  default: "",        null: false
    t.text     "body",                     default: "",        null: false
    t.string   "synopsis",    limit: 1024
    t.string   "illustrator", limit: 128
    t.integer  "position",                 default: 1,         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_tokens", force: true do |t|
    t.integer  "email_address_id"
    t.string   "token",            limit: 64,                                  null: false
    t.string   "user_agent",       limit: 500
    t.string   "ip_address",       limit: 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at",                   default: '2000-01-01 00:00:00', null: false
  end

  add_index "session_tokens", ["token"], name: "index_session_tokens_on_token"

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "access_level",        default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "volumes", force: true do |t|
    t.integer  "number",     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
