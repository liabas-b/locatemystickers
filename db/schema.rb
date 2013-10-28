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

ActiveRecord::Schema.define(:version => 20131028153421) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "friendships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friendships", ["followed_id"], :name => "index_friendships_on_followed_id"
  add_index "friendships", ["follower_id"], :name => "index_friendships_on_follower_id"

  create_table "histories", :force => true do |t|
    t.string   "subject"
    t.string   "operation"
    t.integer  "user_id",                :default => 0
    t.integer  "sticker_id",             :default => 0
    t.integer  "location_id",            :default => 0
    t.integer  "message_id",             :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "notification_level",     :default => 0
    t.integer  "notify",                 :default => 0
    t.integer  "notification_confirmed", :default => 0
  end

  create_table "locations", :force => true do |t|
    t.integer  "sticker_id"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "version",    :default => 0
    t.string   "address"
  end

  add_index "locations", ["sticker_id"], :name => "index_locations_on_sticker_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "from_user_id"
    t.string   "subject"
    t.string   "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "owner_id"
    t.integer  "sticker_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"
  add_index "relationships", ["owner_id"], :name => "index_relationships_on_owner_id"

  create_table "simulations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sticker_id"
    t.integer  "locations_sent"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sticker_configurations", :force => true do |t|
    t.string   "sticker_code"
    t.integer  "frequency_update"
    t.integer  "activate"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "sticker_types", :force => true do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stickers", :force => true do |t|
    t.string   "name"
    t.integer  "sticker_type_id", :default => 1
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "user_id"
    t.integer  "version",         :default => 0
    t.boolean  "is_active",       :default => false
    t.string   "code"
    t.string   "text"
    t.string   "color"
    t.string   "last_location"
    t.float    "last_longitude"
    t.float    "last_latitude"
  end

  add_index "stickers", ["code"], :name => "index_stickers_on_code", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.integer  "compteur",        :default => 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.string   "city"
    t.string   "country"
    t.string   "adress"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "zone_locations", :force => true do |t|
    t.integer  "zone_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "alert_level"
    t.integer  "alerts_on_enter"
    t.integer  "alerts_on_exit"
    t.integer  "sticker_id"
    t.string   "colour"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
