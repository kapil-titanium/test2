class DeliveryZone < ActiveRecord::Base
  attr_accessible   :name, :city_id,:owner, :team, :status, :comments, :base_time
  
  before_save :downcase_fields
  
  has_many :areas
  accepts_nested_attributes_for :areas, :allow_destroy => true
  has_many :kitchens
  belongs_to :city
  
  validates :name, :presence => { :message => "Delivery Zone Required" }, :length => {:maximum => 150}
  validates :city_id, :presence => { :message => "City Required" }
  validates :base_time, :presence => { :message => "Base Time Required" } 
  
  def downcase_fields
      self.name.downcase!
  end
  
   def self.get_active_cities # this method is also used in drop-down of search in layouts.
     City.where(:status => 'active').order('city_name asc')
  end
  
end
