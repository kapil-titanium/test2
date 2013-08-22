class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :basket_id
      t.integer :order_id
      t.integer :meal_category_id
      t.integer :discount_id
      t.integer :quantity, :default => 1
      t.float   :unit_price
      t.float   :total_price
      t.boolean :is_valid, :default => true
      t.boolean :packaging_flag
      t.timestamps
    end
  end
end
