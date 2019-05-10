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

ActiveRecord::Schema.define(version: 20190510022243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "constellation_requests", force: :cascade do |t|
    t.string "reason"
    t.string "name"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_constellation_requests_on_user_id"
  end

  create_table "constellations", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stories", default: 0
    t.boolean "show_on_sign_up", default: false
    t.boolean "is_deleted", default: false
  end

  create_table "content_constellations", force: :cascade do |t|
    t.bigint "content_id"
    t.bigint "constellation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["constellation_id"], name: "index_content_constellations_on_constellation_id"
    t.index ["content_id"], name: "index_content_constellations_on_content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "file"
    t.bigint "user_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disable", default: false
    t.integer "hearts_count", default: 0
    t.boolean "expired", default: false
    t.boolean "shooting_star", default: false
    t.bigint "constellation_request_id"
    t.index ["constellation_request_id"], name: "index_contents_on_constellation_request_id"
    t.index ["shooting_star"], name: "index_contents_on_shooting_star", where: "(shooting_star = true)"
    t.index ["user_id"], name: "index_contents_on_user_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_flags_on_content_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_goals_on_slug"
  end

  create_table "hearts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_hearts_on_content_id"
    t.index ["user_id"], name: "index_hearts_on_user_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "title", null: false
    t.string "icon"
    t.boolean "is_approved", default: false, null: false
    t.boolean "is_deleted", default: false, null: false
    t.bigint "constellation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["constellation_id"], name: "index_planets_on_constellation_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.string "username"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "constellation_requests", "users"
  add_foreign_key "content_constellations", "constellations"
  add_foreign_key "content_constellations", "contents"
  add_foreign_key "contents", "constellation_requests"
  add_foreign_key "flags", "contents"
  add_foreign_key "flags", "users"
  add_foreign_key "hearts", "contents"
  add_foreign_key "hearts", "users"
  add_foreign_key "planets", "constellations"
end
