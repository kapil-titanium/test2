class CreateMealDishes < ActiveRecord::Migration
  def change
    create_table :meal_dishes do |t|
      t.integer     :meal_id
      t.integer     :dish_id
      t.timestamps
    end
  end
end
