# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_18_152332) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_participant_id", null: false
    t.bigint "collection_equation_id", null: false
    t.integer "answer_value"
    t.boolean "correct_answer"
    t.integer "time_spent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "round_id", null: false
    t.index ["collection_equation_id"], name: "index_answers_on_collection_equation_id"
    t.index ["round_id"], name: "index_answers_on_round_id"
    t.index ["user_participant_id"], name: "index_answers_on_user_participant_id"
  end

  create_table "collection_equations", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "equation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collection_equations_on_collection_id"
    t.index ["equation_id"], name: "index_collection_equations_on_equation_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.integer "equations_quantity"
    t.bigint "user_admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_admin_id"], name: "index_collections_on_user_admin_id"
  end

  create_table "equations", force: :cascade do |t|
    t.integer "position_a"
    t.integer "position_b"
    t.integer "position_c"
    t.string "operator"
    t.string "unknown_position"
    t.bigint "user_admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_admin_id"], name: "index_equations_on_user_admin_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_admin_id"], name: "index_groups_on_user_admin_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_admin_id", null: false
    t.bigint "collection_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_reports_on_collection_id"
    t.index ["group_id"], name: "index_reports_on_group_id"
    t.index ["user_admin_id"], name: "index_reports_on_user_admin_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "user_participant_id", null: false
    t.bigint "current_equation_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "equation_started_at"
    t.integer "round_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_rounds_on_collection_id"
    t.index ["current_equation_id"], name: "index_rounds_on_current_equation_id"
    t.index ["user_participant_id"], name: "index_rounds_on_user_participant_id"
  end

  create_table "user_admins", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_admins_on_reset_password_token", unique: true
  end

  create_table "user_participants", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "birth_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_admin_id", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_user_participants_on_group_id"
    t.index ["user_admin_id"], name: "index_user_participants_on_user_admin_id"
  end

  add_foreign_key "answers", "collection_equations"
  add_foreign_key "answers", "rounds"
  add_foreign_key "answers", "user_participants"
  add_foreign_key "collection_equations", "collections"
  add_foreign_key "collection_equations", "equations"
  add_foreign_key "collections", "user_admins"
  add_foreign_key "equations", "user_admins"
  add_foreign_key "groups", "user_admins"
  add_foreign_key "reports", "collections"
  add_foreign_key "reports", "groups"
  add_foreign_key "reports", "user_admins"
  add_foreign_key "rounds", "collections"
  add_foreign_key "rounds", "equations", column: "current_equation_id"
  add_foreign_key "rounds", "user_participants"
  add_foreign_key "user_participants", "groups"
  add_foreign_key "user_participants", "user_admins"
end
