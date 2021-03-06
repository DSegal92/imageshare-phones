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

ActiveRecord::Schema.define(:version => 20120802182342) do

  create_table "active_admin_comments", :force => true do |t|
    t.string    "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "answered_calls", :force => true do |t|
    t.string    "identity"
    t.boolean   "was_target"
    t.string    "elapsed"
    t.integer   "call_id"
    t.integer   "phone_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "calls", :force => true do |t|
    t.string    "target"
    t.string    "origin"
    t.string    "length"
    t.integer   "times_called"
    t.boolean   "was_connected"
    t.string    "caller_ID"
    t.string    "location"
    t.text      "notes"
    t.integer   "answered_id"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
    t.string    "answered"
    t.integer   "menuLength"
    t.integer   "timesCalled"
    t.string    "site"
    t.string    "menuTime"
    t.string    "session"
    t.timestamp "called_on"
  end

  create_table "days", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "value"
  end

  create_table "days_groups", :id => false, :force => true do |t|
    t.integer "day_id"
    t.integer "group_id"
  end

  add_index "days_groups", ["day_id", "group_id"], :name => "index_days_groups_on_day_id_and_group_id"
  add_index "days_groups", ["group_id", "day_id"], :name => "index_days_groups_on_group_id_and_day_id"

  create_table "groups", :force => true do |t|
    t.string    "identity"
    t.integer   "phone_id"
    t.integer   "extension"
    t.string    "email"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "startTime"
    t.integer   "endTime"
    t.integer   "counter"
    t.boolean   "enable"
    t.string    "alias"
    t.time      "start"
    t.time      "endT"
    t.integer   "callback"
  end

  create_table "groups_days", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "day_id"
  end

  add_index "groups_days", ["day_id", "group_id"], :name => "index_groups_days_on_day_id_and_group_id"
  add_index "groups_days", ["group_id", "day_id"], :name => "index_groups_days_on_group_id_and_day_id"

  create_table "groups_phones", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "phone_id"
  end

  add_index "groups_phones", ["group_id", "phone_id"], :name => "index_groups_phones_on_group_id_and_phone_id"
  add_index "groups_phones", ["phone_id", "group_id"], :name => "index_groups_phones_on_phone_id_and_group_id"

  create_table "phones", :force => true do |t|
    t.string    "identity"
    t.string    "number"
    t.integer   "extension"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.boolean   "enable"
    t.string    "email"
  end

  create_table "tropo_settings", :force => true do |t|
    t.text     "welcome"
    t.text     "choices"
    t.string   "song"
    t.integer  "timeout"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
