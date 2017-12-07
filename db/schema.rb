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

ActiveRecord::Schema.define(version: 20171207192903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "collection_id", null: false
    t.integer "position"
    t.index ["collection_id"], name: "index_categories_on_collection_id"
    t.index ["name", "collection_id"], name: "index_categories_on_name_and_collection_id", unique: true
    t.index ["name"], name: "index_categories_on_name"
    t.index ["slug", "collection_id"], name: "index_categories_on_slug_and_collection_id", unique: true
    t.index ["slug"], name: "index_categories_on_slug"
  end

  create_table "categories_packages", id: false, force: :cascade do |t|
    t.integer "package_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_categories_packages_on_category_id"
    t.index ["package_id", "category_id"], name: "index_categories_packages_on_package_id_and_category_id", unique: true
    t.index ["package_id"], name: "index_categories_packages_on_package_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.boolean "default", default: true
    t.index ["name"], name: "index_collections_on_name", unique: true
    t.index ["slug"], name: "index_collections_on_slug", unique: true
  end

  create_table "collections_packages", id: false, force: :cascade do |t|
    t.integer "collection_id", null: false
    t.integer "package_id", null: false
    t.index ["collection_id", "package_id"], name: "index_collections_packages_on_collection_id_and_package_id", unique: true
    t.index ["collection_id"], name: "index_collections_packages_on_collection_id"
    t.index ["package_id"], name: "index_collections_packages_on_package_id"
  end

  create_table "filters", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "collection_id", null: false
    t.integer "position"
    t.index ["collection_id"], name: "index_filters_on_collection_id"
    t.index ["name", "collection_id"], name: "index_filters_on_name_and_collection_id", unique: true
    t.index ["name"], name: "index_filters_on_name"
    t.index ["slug", "collection_id"], name: "index_filters_on_slug_and_collection_id", unique: true
    t.index ["slug"], name: "index_filters_on_slug"
  end

  create_table "filters_packages", id: false, force: :cascade do |t|
    t.integer "filter_id", null: false
    t.integer "package_id", null: false
    t.index ["filter_id", "package_id"], name: "index_filters_packages_on_filter_id_and_package_id", unique: true
    t.index ["filter_id"], name: "index_filters_packages_on_filter_id"
    t.index ["package_id"], name: "index_filters_packages_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.string "repo"
    t.string "original_repo"
    t.text "description"
    t.text "original_description"
    t.string "latest_release"
    t.datetime "modified_at"
    t.datetime "published_at"
    t.string "license"
    t.string "homepage"
    t.integer "last_week_downloads"
    t.integer "last_month_downloads"
    t.integer "stars"
    t.text "readme"
    t.boolean "is_fork"
    t.json "manifest"
    t.json "contributors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "languages"
    t.json "downloads"
    t.string "keywords"
    t.integer "total_downloads", default: 0, null: false
    t.text "downloads_svg", default: "", null: false
    t.boolean "whitelisted", default: false
    t.datetime "last_fetched"
    t.boolean "tweeted", default: false
    t.integer "dependents"
    t.boolean "hidden", default: false
    t.string "slug", null: false
    t.string "custom_repo_path"
    t.string "github_homepage"
    t.index "((((to_tsvector('english'::regconfig, COALESCE((name)::text, ''::text)) || to_tsvector('english'::regconfig, COALESCE(original_description, ''::text))) || to_tsvector('english'::regconfig, COALESCE((original_repo)::text, ''::text))) || to_tsvector('english'::regconfig, COALESCE((keywords)::text, ''::text))))", name: "packages_search", using: :gin
    t.index ["name"], name: "index_packages_on_name", unique: true
    t.index ["slug"], name: "index_packages_on_slug", unique: true
    t.index ["state"], name: "index_packages_on_state"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "collections"
  add_foreign_key "filters", "collections"
end
