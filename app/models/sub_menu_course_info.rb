class SubMenuCourseInfo < ActiveRecord::Base
  attr_accessible :sub_menu_id, :course_id, :min_qty, :max_qty
  
  # Relations
  belongs_to :sub_menu
  belongs_to :course
  
  # Validations
  validates :sub_menu_id, :course_id, :presence => true
end
