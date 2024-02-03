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

ActiveRecord::Schema[7.1].define(version: 2024_01_29_145548) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.text "description"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_name", "team_id"], name: "index_categories_on_category_name_and_team_id", unique: true
    t.index ["team_id"], name: "index_categories_on_team_id"
  end

  create_table "category_projects", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "project_id"], name: "index_category_projects_on_category_id_and_project_id", unique: true
    t.index ["category_id"], name: "index_category_projects_on_category_id"
    t.index ["project_id"], name: "index_category_projects_on_project_id"
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name", null: false
    t.text "description"
    t.integer "policy", default: 0, null: false
    t.integer "progress", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.date "due_date", null: false
    t.bigint "team_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_projects_on_creator_id"
    t.index ["project_name", "creator_id"], name: "index_projects_on_project_name_and_creator_id", unique: true
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.text "description"
    t.integer "order", default: 0, null: false
    t.integer "progress", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.date "due_date", null: false
    t.bigint "project_id", null: false
    t.bigint "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["task_name", "project_id", "assignee_id"], name: "index_tasks_on_task_name_and_project_id_and_assignee_id", unique: true
  end

  create_table "team_users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "user_id"], name: "index_team_users_on_team_id_and_user_id", unique: true
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name", null: false
    t.text "description"
    t.bigint "creator_id", null: false
    t.integer "policy", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_teams_on_creator_id"
    t.index ["team_name", "creator_id"], name: "index_teams_on_team_name_and_creator_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "image_url"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "teams"
  add_foreign_key "category_projects", "categories"
  add_foreign_key "category_projects", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "projects", "teams"
  add_foreign_key "projects", "users", column: "creator_id"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "teams", "users", column: "creator_id"
end
