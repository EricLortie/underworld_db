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

ActiveRecord::Schema.define(version: 20170313005701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_steps", force: :cascade do |t|
    t.string   "user_id"
    t.string   "character_id"
    t.string   "rulebook"
    t.string   "category"
    t.integer  "step"
    t.text     "character"
    t.string   "pc_class"
    t.string   "vocation"
    t.string   "occupation"
    t.string   "race"
    t.string   "skill"
    t.integer  "skill_count"
    t.integer  "frags_spent"
    t.integer  "spell_spheres"
    t.integer  "cp_spent"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["id"], name: "index_character_steps_on_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "full_name"
    t.string   "password_digest"
    t.string   "token"
    t.text     "description"
    t.index ["token"], name: "index_users_on_token", unique: true, using: :btree
  end

end
