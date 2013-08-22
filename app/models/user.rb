class User < ActiveRecord::Base
  attr_accessible :login_id, :first_name, :middle_name, :last_name, :gender, :marital_status, :dob, :anniversary_date,
                  :primary_email_id, :alternate_email_id, :primary_mobile_number, :alternate_contact_number,
                  :company_name, :role_designation, :company_phone_number, :company_extension_number,
                  :is_veg, :food_preferences, :alerts, :user_type, :terms_conditions, :status, :addresses_attributes
  
  before_save :set_default, :capitalize_attributes, :downcase_attributes
  
  # ------------------------User Login Relations----------------------------
  belongs_to :login
  accepts_nested_attributes_for :login, :reject_if => :all_blank
  validates_associated :login, :on => :create
  
  # ------------------------User Addresses Relations----------------------------
  has_many :addresses, :dependent => :destroy
  accepts_nested_attributes_for :addresses, :reject_if => :all_blank, :allow_destroy => true
  
  # ------------------------User Kitchen Relations----------------------------
  has_one :kitchen
  accepts_nested_attributes_for :kitchen, :reject_if => :all_blank
  
  # ------------------------User Employee Relations----------------------------
  has_one :employee
  accepts_nested_attributes_for :employee, :reject_if => :all_blank
  
  #---------------------------User Basket Relation--------------------------
  has_one :basket
  has_many :orders
  # ------------------------User's Validation----------------------------
  
  validates :first_name, :length => {:maximum => 100}, :allow_blank => true
  validates :first_name, :presence => { :message => "Please Enter First Name" }, :length => {:maximum => 100}, :on => :update
  validates :middle_name, :length => {:maximum => 100}, :allow_blank => true
  validates :last_name, :length => {:maximum => 100}, :allow_blank => true
  validates :last_name, :presence => { :message => "Please Enter Last Name" }, :length => {:maximum => 100}, :on => :update
  validates :primary_email_id, :presence => { :message => "Please Enter Email ID" }, :format => { :with => EMAIL_REGEX }
  validates :alternate_email_id , :length => {:maximum => 256}, :format => { :with => EMAIL_REGEX }, :allow_blank => true
  validates :primary_mobile_number, :presence => { :message => "Please Enter Mobile Number" }, :format => { :with => /\A[1-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 10 }, :numericality => true
  
  validates :alternate_contact_number, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 11 }, :numericality => true, :allow_blank => true
  validates :company_phone_number, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 11 }, :numericality => true, :allow_blank => true
  validates :company_extension_number, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 3, :maximum => 11 }, :numericality => true, :allow_blank => true
  #validates :terms_conditions, :acceptance => true, :on => :create, :accept => true#, :accept => true
  validates_acceptance_of :terms_conditions, :accept => true, :on => :create
  # ------------------------User's Custom Validation----------------------------
  validate :email_id?
  validate :compare_email_id?
  validate :unique_username?, :on => :create
  
  def email_id?
    if self.primary_email_id == "example@rasoiclub.com"
      errors.add(:primary_email_id, "Please enter valid email address.")
      return false
    end
  end
  
  def compare_email_id?
    if (alternate_email_id.present?) && (primary_email_id == alternate_email_id)
       errors.add(:alternate_email_id, "should be different than primary email id")
       return false
    end
  end
 
  def unique_username?
    if Login.exists?(self.primary_email_id)
      errors.add(:primary_email_id, "Already taken, please try with different email address.")
      return false
    end 
  end
  
  # ------------------------User's Methods----------------------------
  def get_name
    if self.is_kitchen? 
      "#{self.kitchen.kitchen_name}"
    else
     "#{self.first_name} #{self.last_name}"
    end
  end
  
  def get_email
     "#{self.primary_email_id}"
  end
  
  def get_name_or_email
    self.first_name.present? ? "#{self.first_name} #{self.last_name}" : "#{self.primary_email_id}"
  end
  # ------------------------User's Methods For Identification----------------------------
  
  def is_kitchen?
    self.id.present? && self.user_type == USER_TYPE_KITCHEN && self.kitchen.present?
  end
  
  def is_user?
    self.id.present? && self.user_type == USER_TYPE_CUSTOMER && !self.kitchen.present? #&& !self.employee.present?
  end
  
  def is_employee?
    self.id.present? && self.user_type == USER_TYPE_EMPLOYEE && self.employee.present?
  end
  
  # ------------------------User's default methods----------------------------
  protected
  
  def set_default
      self.user_type ||= USER_TYPE_CUSTOMER
      self.status = USER_STATUS_ACTIVE
  end
  
  def capitalize_attributes
    self.first_name.capitalize! if self.first_name.present?
    self.middle_name.capitalize! if self.middle_name.present?
    self.last_name.capitalize! if self.last_name.present?
  end
  
  def downcase_attributes
    self.alternate_email_id.downcase! if !self.alternate_email_id.blank?
    self.primary_email_id.downcase! if !self.primary_email_id.blank? 
  end
end
