class KitchenOrder < ActiveRecord::Base
  attr_accessible :kitchen_id, :order_id
  
  #--- Relations ---#
  belongs_to :kitchen
  belongs_to :order
  has_many :kitchen_order_line_items
  has_many :line_items , :through => :kitchen_order_line_items
end
