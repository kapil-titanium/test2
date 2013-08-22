class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :description
      t.string :image
      t.integer :gallery_id
      t.integer :dish_id
      t.integer :meal_id
      t.timestamps
    end
  end
end
