class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :menu_id, :null => false
      t.string :category_name
      t.text :description
      t.float :packaging_price
      t.string :slug
      t.timestamps
    end
  end
end
