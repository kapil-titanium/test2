class LineItem < ActiveRecord::Base
  include BasketsHelper
  
  attr_accessible :basket_id, :order_id, :meal_category_id, :discount_id, :quantity, :unit_price, :total_price, :packaging_flag, :is_valid
   
   
  #--- Validations ---#
  #validates :basket_id, :presence => true
  validates :meal_category_id, :presence => true
  validates :quantity, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :unit_price, :numericality => true, :allow_blank => true
  validates :total_price, :numericality => true, :allow_blank => true
  
  
  #--- Relations ---#
  belongs_to :basket
  belongs_to :order
  belongs_to :meal_category
  has_many :kitchen_order_line_items
  has_many :kitchen_orders , :through => :kitchen_order_line_items
  has_many :kitchens, :through => :kitchen_orders

  belongs_to :meal_category
  belongs_to :order
  #--- Actions ---#  
  def update_line_item
    self.unit_price = MealCategory.find(self.meal_category_id).rc_total_price
    self.total_price = self.unit_price * self.quantity
  end


  #--- Callbacks ---#
  private
  
  before_save :update_line_item

  
end
