class Payment < ActiveRecord::Base
  attr_accessible :order_id, :amount, :method, :settled_employee_id
  
  #--- Relations ---#
  belongs_to :order
  belongs_to :settled_employee, :class_name => :employee
end
