class Dish < ActiveRecord::Base
   attr_accessible :picture_attributes, :dish_name, :kitchen_id, :course_id
   
   # Relations
   belongs_to :kitchen
   
   has_many :meals, :through => :meal_dishes
   
   belongs_to :course
   
   has_many :meal_dishes
   
   #Validation
   validates :dish_name, :length => {:maximum => 100}, :presence => { :message => "Please Enter Dish Name" }
   validates :course_id, :presence => true, :presence => { :message => "Course type Required" }
end
