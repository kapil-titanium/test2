class CutOffHour < ActiveRecord::Base
   attr_accessible :time, :unit, :menu_id
   
   #Relation
   has_many :kitchen_cut_off_hours
   has_many :kitchens, :through => :kitchen_cut_off_hours
   
   #Validation 
    validates :time, :presence => {:message => "Time Required"}
    #validates :unit, :presence => {:message => "Unit Required"}
end
