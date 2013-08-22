class CreateKitchenSizeLimits < ActiveRecord::Migration
  def change
    create_table :kitchen_size_limits do |t|
      t.integer :kitchen_id
      t.integer :menu_id
      t.integer :size_limit_id
      t.timestamps
    end
  end
end
