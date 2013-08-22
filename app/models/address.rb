class Address < ActiveRecord::Base
  attr_accessible :user_id, :name, :line1, :line2, :line3, :landmark, :area, :city,
                  :state, :pincode, :country, :is_default
                  
  before_save :downcase_attribute
  
  # ------------------------Address User Relations----------------------------
  belongs_to :user
  
  # ------------------------Address's Validations----------------------------
  validates :line1, :length => {:minimum => 1, :maximum => 256}, :presence => { :message => "Address Line 1 Required" }
  validates :landmark, :length => {:maximum => 100}, :allow_blank => true
  validates :area, :length => {:maximum => 50}, :presence => { :message => "Please select Area " }
  validates :city, :length => {:maximum => 50}, :presence => { :message => "City Required" }
  validates :state, :length => {:maximum => 50}, :presence => { :message => "Please select State" }
  validates :country, :length => {:maximum => 50}, :presence => { :message => "Country Required" }  
  validates :pincode, :presence => { :message => "Pincode Required" }, :numericality => true,:length => { :minimum => 6, :maximum =>6 }  
  
  # ------------------------Address's Methods----------------------------
  
  # ------------------------Address's Default Methods----------------------------
  
  protected
  def downcase_attribute
    self.area.downcase!
    self.city.downcase!    
  end
  
end
