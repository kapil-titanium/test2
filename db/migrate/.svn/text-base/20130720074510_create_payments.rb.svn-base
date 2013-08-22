class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.float :amount
      t.string :method
      t.integer :settled_employee_id
      t.timestamps
    end
  end
end
