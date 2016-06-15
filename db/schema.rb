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

ActiveRecord::Schema.define(version: 20160613232132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fitbit_credentials", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "avatar_url"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "refresh_token"
    t.string   "token_expiration"
  end

  add_index "fitbit_credentials", ["user_id"], name: "index_fitbit_credentials_on_user_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "intensity"
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "spotify_credentials", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "token_expiration"
    t.string   "avatar_url"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "spotify_credentials", ["user_id"], name: "index_spotify_credentials_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fitbit_credentials", "users"
  add_foreign_key "playlists", "users"
  add_foreign_key "spotify_credentials", "users"
end
