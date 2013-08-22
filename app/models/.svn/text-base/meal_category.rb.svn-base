class MealCategory < ActiveRecord::Base
  attr_accessible :meal_id, :category_id, :rc_total_price, :status

  #--- Relations ---#
  belongs_to :meal
  belongs_to :category
  has_many :line_items 
  has_many :orders, :through => :line_items  
  #--- Scope ---#
  scope :all_active, where(:status => :active)   
end
