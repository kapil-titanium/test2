class CreateOutPayments < ActiveRecord::Migration
  def change
    create_table :out_payments do |t|
      t.integer :order_id
      t.float :amount
      t.string :method
      t.integer :creator_id
      t.integer :approver_id
      t.string :status
      t.timestamps
    end
  end
end
