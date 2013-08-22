class CreateKitchens < ActiveRecord::Migration
  def change
    create_table :kitchens do |t|
      
      t.integer "user_id"
      # -------------- Personal Information-------------
      t.string  "kitchen_name"
      t.string  "primary_contact_name"
      t.string  "last_name"
      t.string  "primary_contact_number"
      t.string  "alternative_contact_number"
      t.string  "primary_email_id"
      t.string  "alternative_email_id"
      t.text    "description"
      t.string  "tag_line"
      t.boolean "agreement"
      t.text    "cuisine_style"
      t.integer "delivery_zone_id"
      
      # -------------- Personal Information-------------
      t.integer "cover_pic_id"
      t.integer "profile_pic_id"
      
      # -------------- Facebook Information-------------
      t.boolean "facebook_account", :default => false
      t.string  "facebook_account_name"
      t.string  "facebook_url"
      
      # -------------- Account Information-------------
      t.string  "account_name"
      t.string  "account_number"
      t.string  "bank_name"
      t.string  "branch"
      t.string  "ifsc_code"
      t.string  "payment_preference"
      
      # -------------- Rating Information-------------
      t.float  "avg_dishes_rating", :default => 0.0
      
      # -------------- Account Status Information-------------
      t.string  "status"
      t.boolean "is_open", :default => false
      t.text    "status_comment"
      t.integer "status_changed_by"
      t.datetime "status_changed_on"

      t.timestamps
    end
  end
end
