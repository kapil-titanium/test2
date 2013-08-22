class SubMenu < ActiveRecord::Base
  attr_accessible  :menu_id, :sub_menu_name, :description, :rc_price_range_min, :rc_price_range_max, :sub_menu_packaging_price
  
  # Relations
  belongs_to :menu
  has_one :meal
  has_many :sub_menu_course_infos
  has_many :courses, :through => :sub_menu_course_infos

  # Validations
  validates :menu_id, :presence => true
  validates :sub_menu_name, :length => {:maximum => 50}, :presence => true
  validates :rc_price_range_min, :presence => true, :numericality => true
  validates :rc_price_range_max, :presence => true, :numericality => true
  validates :sub_menu_packaging_price, :presence => true, :numericality => true
  # Friendly ID
  extend FriendlyId
  friendly_id :sub_menu_name, use: [:slugged, :history] 
end
