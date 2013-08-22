class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :menu_name
      t.text :description
      t.string :slug
      t.timestamps
    end
  end
end
