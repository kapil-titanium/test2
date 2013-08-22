class CreateMealCategories < ActiveRecord::Migration
  def change
    create_table :meal_categories do |t|
      t.integer   :meal_id
      t.integer   :category_id
      t.float     :rc_total_price
      t.string    :status
      t.timestamps
    end
  end
end
