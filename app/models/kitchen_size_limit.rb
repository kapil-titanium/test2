class KitchenSizeLimit < ActiveRecord::Base
  attr_accessible :kitchen_id, :menu_id, :size_limit_id
  
  # ------------------------KitchenSizeLimit SizeLimit Relations----------------------------
  belongs_to :size_limit
  
  # ------------------------KitchenSizeLimit Menu Relations----------------------------
  belongs_to :kitchen
  
end
