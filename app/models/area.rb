class Area < ActiveRecord::Base
  attr_accessible   :area_name, :pincode, :status, :comments, :delivery_zone_id
  
  before_save :downcase_fields, :set_default
  
  belongs_to :delivery_zone
  has_many :baskets
  # belongs_to :city, :through => :delivery_zone
  
  validates :area_name, :presence => { :message => "Area name should not be blank" }, :length => {:maximum => 150}
  validates :pincode, :presence => { :message => "Pincode should not be blank" }, :numericality => true,:length => { :minimum => 6, :maximum =>6 }
  validate  :unique_entry?
  
  def unique_entry?
      if (!self.id.present? && Area.where('LOWER(area_name) = ? AND pincode = ?', self.area_name.downcase, self.pincode).present?) || (self.id.present? && Area.where('LOWER(area_name) = ? AND pincode = ? AND id != ?', self.area_name.downcase, self.pincode, self.id).present?)
        errors.add(:area_name, "Area is already available")
        return false
      end
  end
  
  def downcase_fields
      self.area_name.downcase!
  end
  
  def set_default
      self.status = AREA_STATUS_ACTIVE
  end
  
  def area_name_titleized
      self.area_name.titleize
  end
end
