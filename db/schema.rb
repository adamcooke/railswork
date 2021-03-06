# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 8) do

  create_table "coupons", :force => true do |t|
    t.string  "code"
    t.string  "amount"
    t.string  "discount_type", :default => "percent"
    t.boolean "global",        :default => true
    t.boolean "expired",       :default => false
    t.integer "uses",          :default => 0
  end

  create_table "jobs", :force => true do |t|
    t.string   "category"
    t.string   "title"
    t.string   "company_name"
    t.string   "location"
    t.string   "company_url"
    t.string   "salary_range"
    t.text     "description"
    t.string   "contact_email"
    t.boolean  "display_email",                                          :default => true
    t.string   "password"
    t.decimal  "cost",                     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "discount",                 :precision => 8, :scale => 2, :default => 0.0
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at"
    t.integer  "listing_length"
    t.text     "application_instructions"
  end

  create_table "paypal_callbacks", :force => true do |t|
    t.text     "callback_data"
    t.string   "txn_id"
    t.string   "payment_status"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "last_login"
    t.integer  "access_level",          :default => 2
    t.boolean  "enabled",               :default => true
    t.string   "surname"
    t.string   "forename"
    t.string   "email"
    t.string   "reset_password_key"
    t.datetime "reset_password_expiry"
    t.string   "auto_login_token"
    t.boolean  "deleted",               :default => false
  end

end
