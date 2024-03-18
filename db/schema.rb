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

ActiveRecord::Schema[7.1].define(version: 2024_03_18_053817) do
  create_table "comments", force: :cascade do |t|
    t.integer "pet_id", null: false
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["pet_id"], name: "index_comments_on_pet_id"
  end

  create_table "friendship_requests", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "recipient_id", null: false
    t.integer "friendship_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friendship_id"], name: "index_friendship_requests_on_friendship_id"
    t.index ["recipient_id"], name: "index_friendship_requests_on_recipient_id"
    t.index ["sender_id"], name: "index_friendship_requests_on_sender_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "pet_id", null: false
    t.integer "friend_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["pet_id"], name: "index_friendships_on_pet_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "locationable_type", null: false
    t.integer "locationable_id", null: false
    t.string "zip_code"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locationable_type", "locationable_id"], name: "index_locations_on_locationable"
  end

  create_table "owners", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "contact_information"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.string "breed"
    t.string "sex"
    t.date "birthday"
    t.boolean "is_vaccinated"
    t.boolean "is_fixed"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "playdates", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.integer "pet_id", null: false
    t.text "title"
    t.text "content"
    t.boolean "species_specific"
    t.integer "pet_limit"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_playdates_on_owner_id"
    t.index ["pet_id"], name: "index_playdates_on_pet_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "pet_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_profile_id"], name: "index_posts_on_pet_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.integer "pet_id"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_profiles_on_owner_id"
    t.index ["pet_id"], name: "index_profiles_on_pet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "pets"
  add_foreign_key "friendship_requests", "friendships"
  add_foreign_key "friendship_requests", "recipients"
  add_foreign_key "friendship_requests", "senders"
  add_foreign_key "friendships", "friends"
  add_foreign_key "friendships", "pets"
  add_foreign_key "owners", "users"
  add_foreign_key "pets", "owners"
  add_foreign_key "playdates", "owners"
  add_foreign_key "playdates", "pets"
  add_foreign_key "posts", "pet_profiles"
  add_foreign_key "profiles", "owners"
  add_foreign_key "profiles", "pets"
end
