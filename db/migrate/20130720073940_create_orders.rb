class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string    :order_number
      t.integer   :parent_id
      t.integer   :kitchen_id
      t.integer   :user_id
      # t.integer   :line_item_id
      t.integer   :billing_address_id
      t.integer   :shipping_address_id
      t.text      :special_instructions
      t.datetime  :delivery_date
      t.text      :remark
      t.string    :status
      t.float     :sub_total
      t.float     :total_tax
      t.float     :delivery_charge
      t.float     :grand_total
      t.boolean   :terms_and_conditions
      t.string    :delivery_time
      t.timestamps
    end
  end
end
