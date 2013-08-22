class Course < ActiveRecord::Base
  attr_accessible :course_name, :description
  
  # Relations
  has_many :sub_menu_course_infos
  has_many :sub_menus, :through => :sub_menu_course_infos
  has_many :dishes
  # Validations
  validates :course_name, :length => {:maximum => 50}, :presence => true
  
  # Friendly ID
  extend FriendlyId
  friendly_id :course_name, use: [:slugged, :history]
end
