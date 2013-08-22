class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :gallery_name
      t.string :description
      t.integer :cover
      t.integer :kitchen_id
      t.timestamps
    end
  end
end
