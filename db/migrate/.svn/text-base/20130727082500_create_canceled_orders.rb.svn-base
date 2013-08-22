class CreateCanceledOrders < ActiveRecord::Migration
  def change
    create_table :canceled_orders do |t|
      t.integer     :kitchen_id
      t.integer     :menu_id
      t.integer     :meal_category_id
      t.string      :order_number
      t.datetime    :sold_date
      t.integer     :canceled_qty
      t.float       :total_price
      t.timestamps
    end
  end
end
