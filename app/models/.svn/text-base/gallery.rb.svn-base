class Gallery < ActiveRecord::Base
  
  attr_accessible :kitchen_id, :cover, :description, :gallery_name, :pictures_attributes
  
  belongs_to :kitchen
  
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures,:allow_destroy => true
  
  validates :gallery_name,  :length => {:maximum => 25}, :presence => { :message => "Album Name can't be blank" }
  validates :description, :length => {:maximum => 50}
end
