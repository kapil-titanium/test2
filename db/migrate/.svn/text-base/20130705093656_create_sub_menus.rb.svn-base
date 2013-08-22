class CreateSubMenus < ActiveRecord::Migration
  def change
    create_table :sub_menus do |t|
      t.integer :menu_id, :null => false
      t.string :sub_menu_name
      t.text :description
      t.float :rc_price_range_min
      t.float :rc_price_range_max
      t.float :sub_menu_packaging_price
      t.string :slug
      t.timestamps
    end
  end
end
