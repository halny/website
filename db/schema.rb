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

ActiveRecord::Schema.define(:version => 20120303202122) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "pages", :force => true do |t|
    t.string   "content"
    t.boolean  "active"
    t.boolean  "show_in_navbar"
    t.time     "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
  end

  create_table "posts", :force => true do |t|
    t.datetime "published_at"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "deleted_at"
    t.boolean  "posted_to_facebook"
  end

  create_table "race_registrations", :force => true do |t|
    t.boolean  "is_student"
    t.boolean  "is_member"
    t.string   "email"
    t.string   "telephone"
    t.string   "name"
    t.string   "lastname"
    t.integer  "paid"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_variant_id"
    t.integer  "user_id"
    t.time     "deleted_at"
  end

  create_table "race_variants", :force => true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_id"
    t.time     "deleted_at"
  end

  create_table "races", :force => true do |t|
    t.datetime "registration_open_from"
    t.datetime "registration_closed_at"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "deleted_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_student"
    t.boolean  "is_member"
    t.string   "telephone"
    t.string   "name"
    t.string   "lastname"
    t.boolean  "is_admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
