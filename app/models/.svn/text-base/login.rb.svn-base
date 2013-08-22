class Login < ActiveRecord::Base
  attr_accessible   :id, :user_name, :password, :password_confirmation, :attempts, :first_time_login, :login_date,
                    :is_password_change, :question_one, :answer_one, :question_two, :answer_two, :old_password
  
  attr_accessor :old_password  
  before_save :downcase_attribute                  
  
  # ------------------------Login User Relations----------------------------
  has_one :user
  
  has_secure_password
  
  # ------------------------Login's validations----------------------------
  
  validates :user_name, :presence => { :message => "Email ID is not in correct format" }, :length => {:maximum => 256}, :format => { :with => EMAIL_REGEX }, :uniqueness => true
  validates :password, :presence => {:message => "Password Required"}, :confirmation => true, :format => { :with => PASSWORD_REGEX }, :length => { :minimum => 6, :message =>  'Minimum length 6 charater.'}, :on => :create
  validates :password, :presence => true, :confirmation => true, :format => { :with => PASSWORD_REGEX }, :length => { :minimum => 6, :message =>  'Minimum length 6 charater.'}, :on => :update, :unless => lambda{ |l| l.password.blank? }
  validates :password_confirmation, :presence => {:message => "Password confirmation can not be blank"}, :length => { :minimum => 6, :message =>  'Minimum length 6 charater.'}
  
  # ------------------------Login Methods----------------------------
  
  def self.create_login(primary_email_id, password)
    l = Login.new(:user_name => primary_email_id)    
    l.password_confirmation = l.password = password
    return l
  end
  
  def self.exists?(email_id)
    lgn = Login.find_by_user_name(email_id.downcase)
    !lgn.nil?
  end
  
  # ------------------------Login's Default Methods----------------------------
  
  protected
  def downcase_attribute
    self.user_name.downcase!    
  end
end
