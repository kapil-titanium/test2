class SizeLimit < ActiveRecord::Base
  attr_accessible :min_limit, :max_limit
  
  # ------------------------Kitchen SizeLimit Relations----------------------------
  has_many :kitchens, :through => :kitchen_size_limit
  
  # ------------------------SizeLimit KitchenSizeLimit Relations----------------------------
  has_many :kitchen_size_limits
  
end
