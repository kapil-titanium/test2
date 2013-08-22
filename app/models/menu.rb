class Menu < ActiveRecord::Base
  attr_accessible :menu_name, :description
  
  # Relations
  has_many :sub_menus, :dependent => :destroy
  accepts_nested_attributes_for :sub_menus, :allow_destroy => true
  
  has_many :categories, :dependent => :destroy
  accepts_nested_attributes_for :categories, :allow_destroy => true
  
  has_many :kitchen_cut_off_hours
  has_many :ledgers
  # Validations
  validates :menu_name, :length => {:maximum => 50}, :presence => true
  
  # Friendly ID
  extend FriendlyId
  friendly_id :menu_name, use: [:slugged, :history]
end
