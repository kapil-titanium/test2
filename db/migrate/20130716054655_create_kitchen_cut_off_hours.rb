class CreateKitchenCutOffHours < ActiveRecord::Migration
  def change
    create_table :kitchen_cut_off_hours do |t|
      t.integer   :kitchen_id
      t.integer   :menu_id
      t.integer   :cut_off_hour_id
      t.timestamps
    end
  end
end
