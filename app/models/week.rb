class Week < ActiveRecord::Base
   attr_accessible :meal_id, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday

 #callback
   #before_save :default_values
  
 #Relation
   belongs_to :meal
  
 #Validation
  # validates :meal_id, :presence => {:message => 'Meal Requried'}
  
  def default_values
    self.sunday ||= false
    self.monday ||= false
    self.tuesday ||= false
    self.wednesday ||= false
    self.thursday ||= false
    self.friday ||= false
    self.saturday ||= false
  end
end
