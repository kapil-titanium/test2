class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer   :delivery_zone_id
      t.string    :area_name
      t.integer   :pincode
      t.string    :status
      t.text      :comments
      t.timestamps
    end
  end
end
