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

ActiveRecord::Schema.define(:version => 20121129223913) do

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bookmarks", ["message_id"], :name => "index_bookmarks_on_message_id"
  add_index "bookmarks", ["topic_id"], :name => "index_bookmarks_on_topic_id"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "follows", :force => true do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "follows", ["followable_id"], :name => "index_follows_on_followable_id"
  add_index "follows", ["followable_type"], :name => "index_follows_on_followable_type"
  add_index "follows", ["user_id"], :name => "index_follows_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "topics_count",   :default => 0
    t.integer  "messages_count", :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "updater_id"
    t.integer  "position"
  end

  add_index "forums", ["slug"], :name => "index_forums_on_slug", :unique => true
  add_index "forums", ["updater_id"], :name => "index_forums_on_updater_id"

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "forum_id",         :default => 0
    t.datetime "deleted_at"
    t.text     "rendered_content"
    t.integer  "updater_id"
  end

  add_index "messages", ["topic_id"], :name => "index_messages_on_topic_id"
  add_index "messages", ["updater_id"], :name => "index_messages_on_updater_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notifications", ["message_id"], :name => "index_notifications_on_message_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["forum_id"], :name => "index_roles_on_forum_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "small_messages", :force => true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "forum_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "small_messages", ["forum_id"], :name => "index_small_messages_on_forum_id"
  add_index "small_messages", ["message_id"], :name => "index_small_messages_on_message_id"
  add_index "small_messages", ["topic_id"], :name => "index_small_messages_on_topic_id"
  add_index "small_messages", ["user_id"], :name => "index_small_messages_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.integer  "messages_count",  :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "deleted_at"
    t.string   "slug"
    t.integer  "views_count",     :default => 0, :null => false
    t.integer  "viewer_id"
    t.integer  "updater_id"
    t.integer  "last_message_id"
    t.boolean  "pinned"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["last_message_id"], :name => "index_topics_on_last_message_id"
  add_index "topics", ["slug"], :name => "index_topics_on_slug", :unique => true
  add_index "topics", ["updater_id"], :name => "index_topics_on_updater_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"
  add_index "topics", ["viewer_id"], :name => "index_topics_on_viewer_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "messages_count",         :default => 0
    t.integer  "topics_count",           :default => 0
    t.string   "name"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "location"
    t.string   "website"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.string   "slug"
    t.boolean  "human",                  :default => false
    t.boolean  "sysadmin",               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
