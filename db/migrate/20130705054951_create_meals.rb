class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string    :meal_name
      t.integer   :sub_menu_id
      t.integer   :kitchen_id
      t.integer   :week_id
      t.text      :description
      t.boolean   :is_veg
      t.string    :cuisine
      t.string    :spicey_level
      t.string    :status
      t.float     :kitchen_price
      t.text      :serving_size
      t.integer   :original_id
      t.integer   :min_capacity
      t.integer   :max_capacity
      t.boolean   :is_deleted, :default => false
      t.timestamps
    end
  end
end
