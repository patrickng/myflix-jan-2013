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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130306000311) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "video_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "following_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "following_relationships", ["followed_id"], :name => "index_following_relationships_on_followed_id"
  add_index "following_relationships", ["follower_id", "followed_id"], :name => "index_following_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "following_relationships", ["follower_id"], :name => "index_following_relationships_on_follower_id"

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_full_name"
    t.string   "recipient_email_address"
    t.text     "recipient_message"
    t.datetime "sent_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "queue_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "rating"
    t.integer  "max_rating", :default => 5
    t.text     "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "video_id"
  end

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "email_address"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "small_cover_url"
    t.string   "large_cover_url"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
