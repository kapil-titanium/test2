class Basket < ActiveRecord::Base
  include ApplicationHelper
  
  attr_accessible :line_items_attributes, :user_id, :billing_address_id, :shipping_address_id, :delivery_charge, 
                  :sub_total, :total_tax, :grand_total, :total_quantity, :special_instruction 

  
  #--- Validations ---#
  validates :total_quantity, :numericality => {:only_integer => true}, :allow_blank => true
  validates :sub_total, :numericality => true, :allow_blank => true
  validates :total_tax, :numericality => true, :allow_blank => true
  validates :grand_total, :numericality => true, :allow_blank => true
  
  
  #--- Relations ---#
  belongs_to :user
  
  has_many :line_items, :dependent => :destroy
  accepts_nested_attributes_for :line_items, :allow_destroy => true

  belongs_to :bill_address, :foreign_key => :billing_address_id, :class_name => "Address"
  alias_attribute :billing_address, :bill_address

  belongs_to :ship_address, :foreign_key => :shipping_address_id, :class_name => "Address"
  alias_attribute :shipping_address, :ship_address
    
  
  #--- Actions ---#
  def contain_different_delivery_zone?
      return false if !self.line_items.present?
      dz_id = self.line_items.first.meal_category.meal.kitchen.delivery_zone_id
      self.line_items.each do |li|
        return true if dz_id != li.meal_category.meal.kitchen.delivery_zone_id
      end
      return false
  end

    
  def get_delivery_zone
      return false if !self.line_items.present?
      flag = true
      dz = self.line_items.first.meal_category.meal.kitchen.delivery_zone
      
      self.line_items.each do |li|
        flag = false if dz.id != li.meal_category.meal.kitchen.delivery_zone_id
      end
      
      if flag
         return dz
      else
         return nil
      end
  end


 # def is_from_same_city?
 #     city = self.line_items.first.meal_category.meal.kitchen.address_city
 #     self.line_items.each do |li|
 #       return false if city != li.meal_category.meal.kitchen.address_city
 #     end
 #     return true
 # end


  #def kitchens_unassigned_dz
  #    kitchen_names = []
  #    self.line_items.each do |li|
  #      kitchen_names << li.meal_category.meal.kitchen.kitchen_name if !li.meal_category.meal.kitchen.delivery_zone.present?
  #    end
  #    return kitchen_names
  #end

  
end











    
    

