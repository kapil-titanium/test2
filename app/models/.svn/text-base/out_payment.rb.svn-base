class OutPayment < ActiveRecord::Base
  attr_accessible :order_id, :amount, :method, :creator_id, :approver_id, :status
  
  belongs_to :child_order, :class_name => 'Order'
  belongs_to :creator, :class_name => :employee
  belongs_to :approver, :class_name => :employee
end
