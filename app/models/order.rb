class Order < ActiveRecord::Base
  attr_accessible :order_number, :parent_id, :kitchen_id, :user_id, :billing_address_id, :shipping_address_id, 
                  :special_instructions, :delivery_date, :remark, :status, :sub_total, :total_tax, 
                  :delivery_charge, :grand_total, :terms_and_conditions, :delivery_time
  
  #--- Relations ---#
  belongs_to :user
  
  belongs_to :bill_address, :foreign_key => :billing_address_id, :class_name => "Address"
  alias_attribute :billing_address, :bill_address
  accepts_nested_attributes_for :bill_address


  belongs_to :ship_address, :foreign_key => :shipping_address_id, :class_name => "Address"
  alias_attribute :shipping_address, :ship_address
  accepts_nested_attributes_for :ship_address
  
  has_many :line_items, :dependent => :destroy, :order => "created_at ASC"
  accepts_nested_attributes_for :line_items
  has_many :meal_categories, :through => :line_items
  
  has_one :payment, :dependent => :destroy
  accepts_nested_attributes_for :payment
  
  has_one :out_payment, :dependent => :destroy
  
  has_many :child_orders, :class_name => "Order", :foreign_key => "parent_id"  
  belongs_to :parent, :class_name => "Order", :foreign_key => "parent_id"
  belongs_to :kitchen
  
  has_many :kitchen_orders
  has_many :kitchens, :through => :kitchen_orders
  
  #-------------------Scope for Order-------------------------------------------  
  scope :open_kitchen_orders, where("status IN (?) AND parent_id is not null", [ORDER_STATUS_NEW, ORDER_STATUS_OPEN ])
  scope :kitchen_order_history, where('status NOT IN (?)', [ORDER_STATUS_NEW, ORDER_STATUS_OPEN])
  scope :open_user_orders, where('status != ? AND status != ?', ORDER_STATUS_CLOSED, ORDER_STATUS_CANCELED)
  scope :user_order_histroy, where('status = ? AND status = ?', ORDER_STATUS_CLOSED, ORDER_STATUS_CANCELED)
  scope :open_parents, where('status IN (?) AND parent_id is null', [ORDER_STATUS_NEW, ORDER_STATUS_OPEN])
  scope :open_children, where("status IN (?) AND parent_id is not null", [ORDER_STATUS_NEW, ORDER_STATUS_OPEN])
  scope :settled_parents, where("status IN (?) AND parent_id is null", [ORDER_STATUS_SETTLED, ORDER_STATUS_PARTIALLY_SETTLED]).order('updated_at desc')
  scope :settled_children, where("status IN (?) AND parent_id is not null", [ORDER_STATUS_SETTLED, ORDER_STATUS_PARTIALLY_SETTLED]).order('updated_at desc')
  scope :cancelled, where(:status => ORDER_STATUS_CANCELED)
  
  #-------------------Methods-------------------------------------------
  def generate_order_number(city)
      c = City.where(:city_name => city.downcase, :status => CITY_STATUS_ACTIVE ).first
      city_code = c.present? ? c.city_code : city.upcase 
      return "#{city_code}-#{self.delivery_date.strftime('%Y%m%d')}-#{self.id}"
  end 
  
  def build_child_order(order, kitchen)
    self.order_number = "#{order.order_number}-#{kitchen.id}"
    self.kitchen_id = kitchen.id
    self.parent_id = order.id
    self.shipping_address_id = order.shipping_address_id
    self.billing_address_id = order.billing_address_id
    self.special_instructions = order.special_instructions
    self.delivery_date = order.delivery_date
    self.status = order.status
    self.line_items = order.line_items.select {|d| d.meal_category.meal.kitchen == kitchen} 
    self.grand_total = 0
    self.line_items.each {|l| self.grand_total += l.meal_category.meal.kitchen_price * l.quantity }
    self.delivery_time = order.delivery_time
  end
  
  def amount_received
    self.payment.amount if payment
  end 
  
  def amount_settled
    self.out_payment.amount if out_payment
  end 
  
  def parent?
    self.parent_id.nil?
  end
  
  def get_line_items
    if self.parent?
      child_orders.order('id asc').collect {|oc| oc.line_items}.flatten if child_orders
    else
      line_items       
    end
  end
  
end
