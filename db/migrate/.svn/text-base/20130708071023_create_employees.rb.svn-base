class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer   "user_id"
      t.string    "first_name", :limit => 50  
      t.string    "middle_name",  :limit => 50
      t.string    "last_name",  :limit => 50
      t.string    "gender", :limit => 50
      t.datetime  "dob"
      t.string    "primary_email_id", :limit =>256
      t.string    "alternate_email_id",  :limit =>256
      t.string    "primary_mobile_number", :limit =>12
      t.string    "alternate_contact_number",  :limit =>12        
      t.string    "status", :limit =>10 , :default => 'active'
      t.timestamps
    end
  end
end
