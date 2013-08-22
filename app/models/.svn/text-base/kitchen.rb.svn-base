class Kitchen < ActiveRecord::Base
  attr_accessible :user_id, :kitchen_name, :primary_contact_name, :last_name, :primary_contact_number,
                  :alternative_contact_number, :primary_email_id, :alternative_email_id, :description, :tag_line, :agreement, :cuisine_style,
                  :cover_pic_id, :profile_pic_id,
                  :facebook_account, :facebook_account_name, :facebook_url,
                  :account_name, :account_number, :bank_name, :branch, :ifsc_code, :payment_preference,
                  :avg_dishes_rating, :status, :is_open, :status_comment, :status_changed_by, :status_changed_on, :comments, :delivery_zone_id,
                  :size_limit_attributes
  
  attr_accessor :comments
  before_save :set_default, :downcase_attributes
  
  has_many :dishes
  has_many :meals
  has_many :kitchen_cut_off_hours
  has_many :cut_off_hours, :through => :kitchen_cut_off_hours
  has_many :meal_categories, :dependent => :destroy, :through => :meals
  has_many :kitchen_orders
  has_many :kitchen_order_line_items, :through => :kitchen_orders
  has_many :line_items, :through => :kitchen_order_line_items
  has_many :orders, :through => :kitchen_orders
  has_many :child_orders, :class_name => 'Order'
  has_many :ledgers
  has_many :canceled_orders
  # ------------------------Kitchen Delivery Zone Relations----------------------------
  belongs_to :delivery_zone
  
  # ------------------------Kitchen Friendly Slug----------------------------
  extend FriendlyId
  friendly_id :kitchen_name, use: [:slugged, :history]
  
  # ------------------------Kitchen User Relations----------------------------
  belongs_to :user
  validates_associated :user
  
  # ------------------------Kitchen Picture Relations----------------------------
  belongs_to :profile_pic, :class_name => 'Picture'
  belongs_to :cover_pic, :class_name => 'Picture'
  
  # ------------------------Kitchen SizeLimit Relations----------------------------
  has_many :size_limits, :through => :kitchen_size_limits
  
  # ------------------------Kitchen KitchenSizeLimit Relations----------------------------
  has_many :kitchen_size_limits
  
  # ------------------------Kitchen Gallery Relations----------------------------
  has_many :galleries, :dependent => :destroy
  accepts_nested_attributes_for :galleries,:allow_destroy => true
  
  # ------------------------Kitchen's Scopes----------------------------
  scope :new_registrations, where(:status => KITCHEN_STATUS_NEW)
  # scope :unapproved, where(:status => KITCHEN_STATUS_NEW)
  scope :to_be_activated, where("status = ? AND (delivery_zone_id IS NOT NULL)", KITCHEN_STATUS_APPROVED)
  scope :approved, where(:status => KITCHEN_STATUS_APPROVED)
  scope :activated, where(:status => KITCHEN_STATUS_ACTIVATED)
  scope :suspended, where(:status => KITCHEN_STATUS_SUSPENDED)
  scope :rejected, where(:status => KITCHEN_STATUS_REJECTED)
  
  # ------------------------Kitchen's validations----------------------------
  validates :kitchen_name, :presence =>{ :message => "Please enter kitchen name" },  :length => {:maximum => 50} 
  # validates :address, :presence =>{ :message => "Please enter address" }, :length => {:maximum => 256}
  # validates :address_area, :presence => { :message => "Please enter area " } , :length =>{:maximum => 100}
  # validates :address_city, :length =>{:maximum => 50}
  # validates :other_address_city, :length =>{:maximum => 50}
  # validates :address_state, :presence => { :message => "Please enter state" }
  # validates :address_pincode, :numericality => true,:length => { :minimum => 6, :maximum =>6 }, :allow_blank => true
  # validates :address_country, :presence => { :message => "Please enter Country " }
  validates :primary_contact_name, :presence => { :message => "Please enter first name" }, :length => {:maximum => 100}
  validates :last_name, :presence => { :message => "Please enter last name" }, :length => {:maximum => 100}
  validates :primary_contact_number, :presence => { :message => "Contact Number Required" }, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 11 }, :numericality => true
  validates :alternative_contact_number, :format => { :with => /\A[0-9][0-9]*\z/i }, :length => { :minimum => 10, :maximum => 11 }, :numericality => true, :allow_blank => true
  validates :primary_email_id,  :presence => { :message => "Please enter email ID" }, :format => { :with => EMAIL_REGEX, :message => 'Please Enter Valid Email Id' }, :uniqueness => true
  validates :alternative_email_id, :length => {:maximum => 256}, :format => { :with => EMAIL_REGEX }, :allow_blank => true
  validates_acceptance_of :agreement, :accept => true, :on => :create 
  #validates :agreement, :presence => { :message => "Please accept Term & Conditions" }, :acceptance => true, :on => :create
  validates :description, :length => { :maximum => 256}
  validates :comments, :length => { :maximum => 256}
  validates :tag_line, :length => { :maximum => 100}
  validate :unique_username?, :on => :create
  validate :alternative_email_check?
  # validate :validate_city?
  
  # ------------------------Kitchen's Methods----------------------------
  def get_address
    self.user.addresses.first if self.user.addresses.present?
  end
  
  def unique_username?
    if Login.exists?(self.primary_email_id)
      errors.add(:primary_email_id, "Already taken, please try with different email address.")
      return false
    end 
  end
  
  def alternative_email_check?
      if ((self.alternative_email_id.present?) && (self.alternative_email_id == self.primary_email_id))
        errors.add(:alternative_email_id, "Email Id should be different from Primary Email Id")
        return false
      end
  end
  
  # def validate_city?
      # if (self.address_city.nil? || self.address_city.blank?) && (self.other_address_city.nil? || self.other_address_city.blank?)
        # errors.add(:address_city, "City Name Required. Or Specify if other")
        # return false
      # end 
  # end
  
  def validate_presence_of_comment(status_comment)
    if status_comment.empty?
       return false
    else
      return true
    end
  end
  
  def average_rating
    dishes.each { |d| d.calculate_average_rating }
    dishes_with_rating = dishes.select { |d| d.average_rating > 0 && d.average_rating.present? }    
    avg = dishes_with_rating.average(:average_rating).to_f.round(2) if dishes_with_rating.present?
    avg
  end
  
  def update_avg_dishes_rating
    avg = average_rating
    self.update_attributes(:avg_dishes_rating => avg.to_f) if avg.present? && avg.to_f > 0 
  end
  
  def self.text_search(city, query, advance_options)    
    joins(:meal_categories, {:user => :addresses}).where("kitchens.status @@ :s AND addresses.city  @@ :p AND (kitchen_name  @@ :q or kitchens.description  @@ :q or addresses.state @@ :q or addresses.area @@ :q or kitchens.cuisine_style @@ :q )", s: KITCHEN_STATUS_ACTIVATED, p: (city.present? ? city.downcase : DEFAULT_SEARCH_CITY_NAME.downcase), q: query).uniq   if query.present? && !advance_options.present?    #TODO: check results r correct or not      
  end

  
  def assign_delivery_zone(area, pincode)
      delivery_area = Area.where('LOWER(area_name) =? AND pincode = ? AND status = ?', area.downcase, pincode ,DELIVERY_ZONE_STATUS_ACTIVE).first if area.present? && pincode.present?
      self.delivery_zone_id = nil
      self.delivery_zone_id = delivery_area.delivery_zone.id if delivery_area.present? && delivery_area.delivery_zone.present?
  end
  
  def notice_time(delivery_date, menu_id, delivery_time = nil)
    delivery_date = delivery_date.to_time if delivery_date.present?
    base_time = nil
    if Menu.find(menu_id).menu_name == MENU_NAME_DINNER
       base_time = self.delivery_zone.base_time
    else
       base_time = delivery_time.to_i - PARTY_PICKUP_HRS
       base_time = Time.new(delivery_date.strftime('%Y').to_i, delivery_date.strftime('%m').to_i, delivery_date.strftime('%d').to_i, base_time, 0, 0 )
    end
    
    cut_off_hour = (self.kitchen_cut_off_hours.where(:menu_id => menu_id).first.cut_off_hour.time) #TODO check this statement
    notice_time = base_time - cut_off_hour*3600  if cut_off_hour.present? && base_time.present?  # notice time only without delivery date
         
                                            # Cut_off_hours must be integer and in forms of hours
    return Time.new(delivery_date.strftime('%Y').to_i, delivery_date.strftime('%m').to_i, delivery_date.strftime('%d').to_i, notice_time.strftime('%H').to_i, 0, 0 )                                                      
  end
  
  def create_kitchen_size_limit(party_sizes, menu)
    if (kitchen_size_limits = self.kitchen_size_limits.find(:all, :conditions => ["menu_id = ?", menu.id])).present?
        if kitchen_size_limits.map(&:size_limit_id).sort == party_sizes.map(&:to_i).sort
        else
          (kitchen_size_limits.map(&:size_limit_id).sort - party_sizes.map(&:to_i).sort).each do |sl|
            self.kitchen_size_limits.find(:all, :conditions => ["menu_id = ? AND size_limit_id = ?", menu.id, sl]).first.destroy
          end
          (party_sizes.map(&:to_i).sort - kitchen_size_limits.map(&:size_limit_id).sort).each do |s|
            self.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => s)
          end
          self.save
        end
    else
      party_sizes.map(&:to_i).each do |s|
        self.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => s)
      end
      self.save
    end  
  end
  
  def add_default_party_size_limit
      menu = Menu.find_by_menu_name(MENU_NAME_PARTY)
      size_limit = SizeLimit.find(:first, :conditions  => [ 'min_limit = ? AND max_limit = ?', MENU_PARTY_DEFAULT_LOWER_LIMIT, MENU_PARTY_DEFAULT_UPPER_LIMIT ])
      self.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => size_limit.id)  
  end
  
  def set_default_kitchen_cut_off_hours
      dinner_cut_off_hour = CutOffHour.find_by_time(DEFAULT_DINNER_CUT_OFF_HOUR)
      party_cut_off_hour = CutOffHour.find_by_time(DEFAULT_PARTY_CUT_OFF_HOUR)
      treat_cut_off_hour = CutOffHour.find_by_time(DEFAULT_RC_TREAT_CUT_OFF_HOUR)

      dinner_cut_off_hour = CutOffHour.create(:time => DEFAULT_DINNER_CUT_OFF_HOUR) if !dinner_cut_off_hour.present?
      party_cut_off_hour = CutOffHour.create(:time => DEFAULT_PARTY_CUT_OFF_HOUR) if !party_cut_off_hour.present?
      treat_cut_off_hour = CutOffHour.create(:time => DEFAULT_RC_TREAT_CUT_OFF_HOUR) if !treat_cut_off_hour.present?
      
      dinner = Menu.find_by_menu_name(MENU_NAME_DINNER)
      party = Menu.find_by_menu_name(MENU_NAME_PARTY)
      treat = Menu.find_by_menu_name(MENU_NAME_TREAT)
        
      self.kitchen_cut_off_hours.build(:menu_id => dinner.id, :cut_off_hour_id => dinner_cut_off_hour.id)
      self.kitchen_cut_off_hours.build(:menu_id => party.id, :cut_off_hour_id => party_cut_off_hour.id)
      self.kitchen_cut_off_hours.build(:menu_id => treat.id, :cut_off_hour_id => treat_cut_off_hour.id)
  end
  
  def update_kitchen_cut_off_hours(params)
     dinner = Menu.find_by_menu_name(MENU_NAME_DINNER)
     party = Menu.find_by_menu_name(MENU_NAME_PARTY)
     treat = Menu.find_by_menu_name(MENU_NAME_TREAT)
     
     dinner_kcoh = self.kitchen_cut_off_hours.where(:menu_id => dinner.id).first
     party_kcoh = self.kitchen_cut_off_hours.where(:menu_id => party.id).first
     treat_kcoh = self.kitchen_cut_off_hours.where(:menu_id => treat.id).first
     
     dinner_kcoh.update_attributes(:cut_off_hour_id => params[:dinner_coh].to_i)
     party_kcoh.update_attributes(:cut_off_hour_id => params[:party_coh].to_i)
     treat_kcoh.update_attributes(:cut_off_hour_id => params[:treat_coh].to_i)
  end
  # ------------------------Kitchen's Default Methods----------------------------
  protected
  
  def set_default
      self.status ||= KITCHEN_STATUS_NEW
  end
  
  def downcase_attributes
      
  end
  
end
