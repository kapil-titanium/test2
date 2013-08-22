class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.integer   :user_id
      t.integer   :billing_address_id
      t.integer   :shipping_address_id
      t.float     :delivery_charge
      t.float     :sub_total
      t.float     :total_tax
      t.float     :grand_total  
      t.integer   :total_quantity
      t.text      :special_instruction  
      t.timestamps
    end
  end
end
