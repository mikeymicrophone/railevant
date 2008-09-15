# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080912052145) do

  create_table "concepts", :force => true do |t|
    t.string   "type"
    t.text     "content"
    t.text     "character"
    t.integer  "bits"
    t.integer  "railser_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "rails_ids"
    t.text     "ties_ids"
    t.text     "ambiguous"
    t.string   "uri"
    t.string   "rail_rs_ids"
    t.string   "tie_rs_ids"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued"
    t.integer "lifetime"
    t.string  "assoc_type"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.string  "nonce"
    t.integer "created"
  end

  create_table "open_id_authentication_settings", :force => true do |t|
    t.string "setting"
    t.binary "value"
  end

  create_table "railevances", :force => true do |t|
    t.integer  "rail_id"
    t.integer  "tie_id"
    t.integer  "railser_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rail_r_id"
    t.integer  "tie_r_id"
    t.string   "rail_rs_ids"
    t.string   "tie_rs_ids"
    t.string   "rails_ids"
    t.string   "ties_ids"
  end

  create_table "railsers", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "person_id"
  end

  create_table "votes", :force => true do |t|
    t.integer  "rating"
    t.integer  "concept_id"
    t.integer  "railevance_id"
    t.string   "characteristic_id"
    t.integer  "railser_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
