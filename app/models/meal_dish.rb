class MealDish < ActiveRecord::Base
   attr_accessible :meal_id, :dish_id
  
  #Relation
  belongs_to :meal
  belongs_to :dish
  
  #Validation
  
end
