class City < ActiveRecord::Base
   attr_accessible :city_name, :city_code, :state, :country, :status
   
   #Relations
   has_many :delivery_zones
   has_many :areas, :through => :delivery_zones

   #Actions
   def self.get_default_city_id
     City.where("lower(city_name) = ?", "pune".downcase).first.id
   end
   
   def self.get_active_cities
       find(:all, :conditions => ['status = ?', CITY_STATUS_ACTIVE]).map(&:city_name).map{|i| i.downcase}
   end
    
end
