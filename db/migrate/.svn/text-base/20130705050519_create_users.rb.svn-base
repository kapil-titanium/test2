class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      
      t.integer   "login_id"
      t.string    "first_name", :limit => 50  
      t.string    "middle_name",  :limit => 50
      t.string    "last_name",  :limit => 50
      t.string    "gender", :limit => 50
      t.string    "marital_status"
      t.datetime  "dob"
      t.datetime  "anniversary_date"      
      t.string    "primary_email_id", :limit =>256
      t.string    "alternate_email_id",  :limit =>256
      t.string    "primary_mobile_number", :limit =>12
      t.string    "alternate_contact_number",  :limit =>12
      t.string    "company_name", :limit =>256
      t.string    "role_designation", :limit =>256
      t.string    "company_phone_number", :limit =>12
      t.string    "company_extension_number", :limit =>12      
      t.boolean   "is_veg", :default => true
      t.string    "food_preferences", :limit =>256
      t.boolean   "alerts", :default => true
      t.string    "user_type", :limit =>64
      t.boolean   "terms_conditions"
      t.string    "status", :limit =>10

      t.timestamps
    end
  end
end
