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

ActiveRecord::Schema[7.1].define(version: 2024_04_06_045351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "name", null: false
    t.decimal "total_rating"
    t.string "image_url"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_games_on_id", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "rating", default: 0, null: false
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.integer "like_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_reviews_on_game_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "user_friends", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_user_friends_on_friend_id"
    t.index ["user_id"], name: "index_user_friends_on_user_id"
  end

  create_table "user_whishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "user_id"], name: "index_user_whishlists_on_game_id_and_user_id", unique: true
    t.index ["game_id"], name: "index_user_whishlists_on_game_id"
    t.index ["user_id"], name: "index_user_whishlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reviews", "games"
  add_foreign_key "reviews", "users"
  add_foreign_key "user_friends", "users"
  add_foreign_key "user_friends", "users", column: "friend_id"
  add_foreign_key "user_whishlists", "games"
  add_foreign_key "user_whishlists", "users"
end
