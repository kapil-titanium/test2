class CreateCutOffHours < ActiveRecord::Migration
  def change
    create_table :cut_off_hours do |t|
      t.integer  :time
      t.string :unit
      t.integer :menu_id
      t.timestamps
    end
  end
end
