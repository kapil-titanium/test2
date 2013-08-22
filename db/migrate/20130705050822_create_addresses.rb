class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      
      t.integer  "user_id"
       t.string   "name", :limit => 256
       t.string   "line1", :limit => 256
       t.string   "line2", :limit => 256
       t.string   "line3", :limit => 256
       t.string   "landmark", :limit => 100
       t.string   "area", :limit => 100
       t.string   "city", :limit => 50
       t.string   "state", :limit => 50
       t.integer  "pincode", :limit => 6
       t.string   "country", :limit =>50              
       t.boolean  "is_default", :default => false

      t.timestamps
    end
  end
end
