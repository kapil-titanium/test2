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

ActiveRecord::Schema.define(:version => 20130730093955) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",       :limit => 256
    t.string   "line1",      :limit => 256
    t.string   "line2",      :limit => 256
    t.string   "line3",      :limit => 256
    t.string   "landmark",   :limit => 100
    t.string   "area",       :limit => 100
    t.string   "city",       :limit => 50
    t.string   "state",      :limit => 50
    t.integer  "pincode",    :limit => 8
    t.string   "country",    :limit => 50
    t.boolean  "is_default",                :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "areas", :force => true do |t|
    t.integer  "delivery_zone_id"
    t.string   "area_name"
    t.integer  "pincode"
    t.string   "status"
    t.text     "comments"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "baskets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.float    "delivery_charge"
    t.float    "sub_total"
    t.float    "total_tax"
    t.float    "grand_total"
    t.integer  "total_quantity"
    t.text     "special_instruction"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "canceled_orders", :force => true do |t|
    t.integer  "kitchen_id"
    t.integer  "menu_id"
    t.integer  "meal_category_id"
    t.string   "order_number"
    t.datetime "sold_date"
    t.integer  "canceled_qty"
    t.float    "total_price"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "categories", :force => true do |t|
    t.integer  "menu_id",         :null => false
    t.string   "category_name"
    t.text     "description"
    t.float    "packaging_price"
    t.string   "slug"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "city_name"
    t.string   "city_code"
    t.string   "state"
    t.string   "country"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "course_name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cut_off_hours", :force => true do |t|
    t.float    "time"
    t.string   "unit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delivery_zones", :force => true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "owner"
    t.string   "team"
    t.string   "status"
    t.text     "comments"
    t.time     "base_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dishes", :force => true do |t|
    t.string   "dish_name"
    t.integer  "kitchen_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name",               :limit => 50
    t.string   "middle_name",              :limit => 50
    t.string   "last_name",                :limit => 50
    t.string   "gender",                   :limit => 50
    t.datetime "dob"
    t.string   "primary_email_id",         :limit => 256
    t.string   "alternate_email_id",       :limit => 256
    t.string   "primary_mobile_number",    :limit => 12
    t.string   "alternate_contact_number", :limit => 12
    t.string   "status",                   :limit => 10,  :default => "active"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "galleries", :force => true do |t|
    t.string   "gallery_name"
    t.string   "description"
    t.integer  "cover"
    t.integer  "kitchen_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "kitchen_cut_off_hours", :force => true do |t|
    t.integer  "kitchen_id"
    t.integer  "menu_id"
    t.integer  "cut_off_hour_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "kitchen_order_line_items", :force => true do |t|
    t.integer  "kitchen_order_id"
    t.integer  "line_item_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "kitchen_orders", :force => true do |t|
    t.integer  "kitchen_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kitchen_size_limits", :force => true do |t|
    t.integer  "kitchen_id"
    t.integer  "menu_id"
    t.integer  "size_limit_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "kitchens", :force => true do |t|
    t.integer  "user_id"
    t.string   "kitchen_name"
    t.string   "primary_contact_name"
    t.string   "last_name"
    t.string   "primary_contact_number"
    t.string   "alternative_contact_number"
    t.string   "primary_email_id"
    t.string   "alternative_email_id"
    t.text     "description"
    t.string   "tag_line"
    t.boolean  "agreement"
    t.text     "cuisine_style"
    t.integer  "delivery_zone_id"
    t.integer  "cover_pic_id"
    t.integer  "profile_pic_id"
    t.boolean  "facebook_account",           :default => false
    t.string   "facebook_account_name"
    t.string   "facebook_url"
    t.string   "account_name"
    t.string   "account_number"
    t.string   "bank_name"
    t.string   "branch"
    t.string   "ifsc_code"
    t.string   "payment_preference"
    t.float    "avg_dishes_rating",          :default => 0.0
    t.string   "status"
    t.boolean  "is_open",                    :default => false
    t.text     "status_comment"
    t.integer  "status_changed_by"
    t.datetime "status_changed_on"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "slug"
  end

  add_index "kitchens", ["slug"], :name => "index_kitchens_on_slug"

  create_table "ledgers", :force => true do |t|
    t.integer  "kitchen_id"
    t.integer  "menu_id"
    t.integer  "meal_category_id"
    t.string   "order_number"
    t.datetime "sold_date"
    t.integer  "sold_qty"
    t.float    "total_price"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "basket_id"
    t.integer  "order_id"
    t.integer  "meal_category_id"
    t.integer  "discount_id"
    t.integer  "quantity",         :default => 1
    t.float    "unit_price"
    t.float    "total_price"
    t.boolean  "is_valid",         :default => true
    t.boolean  "packaging_flag"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "logins", :force => true do |t|
    t.string   "user_name",          :limit => 256
    t.string   "password_digest"
    t.integer  "attempts",                          :default => 0
    t.integer  "first_time_login",                  :default => 0
    t.datetime "login_date"
    t.boolean  "is_password_change",                :default => false
    t.string   "question_one"
    t.string   "answer_one"
    t.string   "question_two"
    t.string   "answer_two"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "meal_categories", :force => true do |t|
    t.integer  "meal_id"
    t.integer  "category_id"
    t.float    "rc_total_price"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "meal_dishes", :force => true do |t|
    t.integer  "meal_id"
    t.integer  "dish_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "meals", :force => true do |t|
    t.string   "meal_name"
    t.integer  "sub_menu_id"
    t.integer  "kitchen_id"
    t.integer  "week_id"
    t.text     "description"
    t.boolean  "is_veg"
    t.string   "cuisine"
    t.string   "spicey_level"
    t.string   "status"
    t.float    "kitchen_price"
    t.text     "serving_size"
    t.integer  "original_id"
    t.integer  "min_capacity"
    t.integer  "max_capacity"
    t.boolean  "is_deleted",    :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "menu_name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "order_number"
    t.integer  "parent_id"
    t.integer  "kitchen_id"
    t.integer  "user_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.text     "special_instructions"
    t.datetime "delivery_date"
    t.text     "remark"
    t.string   "status"
    t.float    "sub_total"
    t.float    "total_tax"
    t.float    "delivery_charge"
    t.float    "grand_total"
    t.boolean  "terms_and_conditions"
    t.string   "delivery_time"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "out_payments", :force => true do |t|
    t.integer  "order_id"
    t.float    "amount"
    t.string   "method"
    t.integer  "creator_id"
    t.integer  "approver_id"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id"
    t.float    "amount"
    t.string   "method"
    t.integer  "settled_employee_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "description"
    t.string   "image"
    t.integer  "gallery_id"
    t.integer  "dish_id"
    t.integer  "meal_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rc_constants", :force => true do |t|
    t.string   "constant_name"
    t.string   "constant_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "filter_text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "size_limits", :force => true do |t|
    t.integer  "min_limit"
    t.integer  "max_limit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_menu_course_criteria", :force => true do |t|
    t.integer  "sub_menu_id", :null => false
    t.integer  "course_id",   :null => false
    t.integer  "min_qty"
    t.integer  "max_qty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sub_menu_course_infos", :force => true do |t|
    t.integer  "sub_menu_id", :null => false
    t.integer  "course_id",   :null => false
    t.integer  "min_qty"
    t.integer  "max_qty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sub_menus", :force => true do |t|
    t.integer  "menu_id",                  :null => false
    t.string   "sub_menu_name"
    t.text     "description"
    t.float    "rc_price_range_min"
    t.float    "rc_price_range_max"
    t.float    "sub_menu_packaging_price"
    t.string   "slug"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "team_employees", :force => true do |t|
    t.integer  "team_id"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.text     "team_description"
    t.string   "team_type"
    t.string   "status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "login_id"
    t.string   "first_name",               :limit => 50
    t.string   "middle_name",              :limit => 50
    t.string   "last_name",                :limit => 50
    t.string   "gender",                   :limit => 50
    t.string   "marital_status"
    t.datetime "dob"
    t.datetime "anniversary_date"
    t.string   "primary_email_id",         :limit => 256
    t.string   "alternate_email_id",       :limit => 256
    t.string   "primary_mobile_number",    :limit => 12
    t.string   "alternate_contact_number", :limit => 12
    t.string   "company_name",             :limit => 256
    t.string   "role_designation",         :limit => 256
    t.string   "company_phone_number",     :limit => 12
    t.string   "company_extension_number", :limit => 12
    t.boolean  "is_veg",                                  :default => true
    t.string   "food_preferences",         :limit => 256
    t.boolean  "alerts",                                  :default => true
    t.string   "user_type",                :limit => 64
    t.boolean  "terms_conditions"
    t.string   "status",                   :limit => 10
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "weeks", :force => true do |t|
    t.integer  "meal_id"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
