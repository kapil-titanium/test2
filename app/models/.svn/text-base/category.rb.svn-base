class Category < ActiveRecord::Base
  attr_accessible :menu_id, :category_name, :description, :packaging_price
  
  # Relations
  belongs_to :menu
  has_many :meal_categories
  has_many :meals, :through => :meal_categories
  
  # Validations
  validates :menu_id, :presence => true
  validates :category_name, :length => {:maximum => 50}, :presence => true
  
  # Friendly ID
  extend FriendlyId
  friendly_id :category_name, use: [:slugged, :history]
end
