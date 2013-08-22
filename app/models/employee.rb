class Employee < ActiveRecord::Base
  attr_accessible :user_id, :first_name, :middle_name, :last_name, :gender, :dob, :primary_email_id, :alternate_email_id,
                  :primary_mobile_number, :alternate_contact_number, :status
                  
  # Relations
  belongs_to :user
  
  has_many :team_employees
  has_many :teams, :through => :team_employees
  
  # Validations
  validates :first_name, :presence => { :message => "First Name Required" }, :length => {:maximum => 100}
  validates :middle_name, :length => {:maximum => 50}, :allow_blank => true
  validates :last_name, :presence => { :message => "Last Name Required" }, :length => {:maximum => 100}
  validates :primary_email_id, :presence => { :message => "Email ID Required" }, :format => { :with => EMAIL_REGEX }
  validates :alternate_email_id , :length => {:maximum => 256}, :format => { :with => EMAIL_REGEX }, :allow_blank => true
  validates :primary_mobile_number, :presence => { :message => "Mobile Number Required" }, :format => { :with => /\A[1-9][0-9]*\z/i, :message => 'Mobile number should be of 10 digit' }, :length => { :minimum => 10, :maximum => 10 }, :numericality => true
  validates :alternate_contact_number, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 11 }, :numericality => true, :allow_blank => true
  validate :compare_email_id?
  validate :unique_username?, :on => :create
  validate :unique_alt_username?
    
  before_save :capitalize_names, :downcase_attributes, :set_default
  
  # Actions
  def get_default_address
    addresses.select{|a| a.is_default == true}.first.flatten if addresses.present? && addresses.any? {|a| a.is_default == true}
  end
  
  def get_full_name
    "#{first_name} #{last_name}"
  end
  
  def unique_username?     
    if User.exists?(:primary_email_id => self.primary_email_id)
      errors.add(:primary_email_id, "Already taken, please try with different email address.")
      return false
    end 
  end
  
  def unique_alt_username?
    if !self.alternate_email_id.blank?
      alt_User = Employee.find_by_alternate_email_id(self.alternate_email_id)
      if alt_User && (self.id != alt_User.id) 
        errors.add(:alternate_email_id, "Already linked with another account, please try with different email address.")
        return false
      end
    end    
  end
  
  def compare_email_id?
    if (alternate_email_id.present?) && (primary_email_id == alternate_email_id)
       errors.add(:alternate_email_id, "should be different than primary email id")
       return false
    end
  end
  
  protected
  def capitalize_names
    self.first_name.capitalize! if self.first_name.present?
    self.middle_name.capitalize! if self.middle_name.present?
    self.last_name.capitalize! if self.last_name.present?   
  end
  
  def downcase_attributes
    self.alternate_email_id.downcase! if self.alternate_email_id.present? 
    self.primary_email_id.downcase! if self.primary_email_id.present?
  end
  
  private
  def set_default
    self.status ||= 'active'
  end

end
