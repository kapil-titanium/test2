class CreateDeliveryZones < ActiveRecord::Migration
  def change
    create_table :delivery_zones do |t|
      t.integer   :city_id
      t.string    :name
      t.string    :owner
      t.string    :team
      t.string    :status
      t.text      :comments
      t.time      :base_time
      t.timestamps
    end
  end
end
