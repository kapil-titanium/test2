class Meal < ActiveRecord::Base
  attr_accessible :picture_attributes, :meal_name, :sub_menu_id, :kitchen_id, :week_id, :description, :is_veg, :cuisine, :spicey_level, 
                    :status, :kitchen_price, :serving_size, :original_id, :is_deleted, :min_capacity, :max_capacity
                    
 # ------------------------Callbacks----------------------------
  before_save :default_status
 
 # ------------------------Relations----------------------------
  belongs_to :kitchen
  
  has_many :meal_categories, :dependent => :destroy
  has_many :categories, :through => :meal_categories
  
  has_many :meal_dishes, :dependent => :destroy
  accepts_nested_attributes_for :meal_dishes
  
  has_many :dishes, :through => :meal_dishes
  
  has_one :picture
  accepts_nested_attributes_for :picture, :allow_destroy => true
  
  has_one :week
  accepts_nested_attributes_for :week
                               # :reject_if => proc { |attrs| attrs['sunday'].eql?("0") and attrs['monday'].eql?("0") and attrs['tuesday'].eql?("0") and attrs['wednesday'].eql?("0") and attrs['thursday'].eql?("0") and attrs['friday'].eql?("0") and attrs['saturday'].eql?("0") },
                               # :allow_destroy => true
  belongs_to :sub_menu
  
 # ------------------------Validation----------------------------
  validates :meal_name, :length => {:maximum => 50}, :presence => {:message => 'Please Enter Meal Name'}
  #validates :sub_menu_id, :presence => {:message => 'Sub Menu Required'}
  validates :description, :presence => {:message => 'Please Enter Meal Description'}, :length => {:maximum => 50}          
  validates :kitchen_price, :presence => {:message => 'Please Enter Meal Price'}
  validates :serving_size, :presence => {:message => 'Serving Size Required'}, :length => {:maximum => 50}
  validates :spicey_level, :presence => {:message => 'Please Select Spicy Level'}
  validates :status, :presence => {:message => 'Status Required'}
  validates :cuisine, :presence => {:message => 'Please Select Cuisine Type'}
  validates :min_capacity, :presence => {:message => 'Please Select Minimum Capacity'}, :numericality => true
  validates :max_capacity, :presence => {:message => 'Please Select Maximum Capacity'}, :numericality => true
  
 # ------------------------Methods----------------------------
  def default_status
    self.status ||= MEAL_STATUS_ACTIVE
  end
  
  def update_or_duplicate_item(params, sub_menu_id, dishes, week)
    new_meal_name = params[:meal_name].present? ? params[:meal_name] :self.meal_name
    new_sub_menu_id = sub_menu_id.present? ? sub_menu_id : self.sub_menu_id
    new_description = params[:description].present? ? params[:description] : self.description
    new_is_veg = params[:is_veg].present? ? params[:is_veg] : self.is_veg
    new_cuisine = params[:cuisine].present? ? params[:cuisine] : self.cuisine
    new_spicey_level = params[:spicey_level].present? ? params[:spicey_level] : self.spicey_level
    new_kitchen_price = params[:kitchen_price].present? ? params[:kitchen_price] : self.kitchen_price
    new_serving_size = params[:serving_size].present? ? params[:serving_size] :  self.serving_size
    new_min_capacity = params[:min_capacity].present? ? params[:min_capacity] :  self.min_capacity
    new_max_capacity = params[:max_capacity].present? ? params[:max_capacity] :  self.max_capacity
    new_week_days = week.present? ? week : self.week
    new_status = params[:status].present? ? params[:status] :self.status
    
    new_original_id = self.original_id if self.original_id.present?
    new_original_id = self.id if !self.original_id.present?
    self.picture = Picture.new(params[:picture_attributes]) if params[:picture_attributes].present? && params[:picture_attributes][:image].present?
    # if self.exist_open_orders? && ( self.sub_menu_id != new_sub_menu_id || self.kitchen_price != new_kitchen_price || self.serving_size != new_serving_size || !(self.dishes.pluck(:dish_id) - dishes).empty? || !(dishes - self.dishes.pluck(:dish_id)).empty?)) #TODO   uncomment the condition for Oder exit for meal or not
    if self.exist_orders? && (self.sub_menu_id != new_sub_menu_id || self.kitchen_price != new_kitchen_price.to_f || self.serving_size != new_serving_size || !(self.dishes.pluck(:dish_id) - dishes).empty? || !(dishes - self.dishes.pluck(:dish_id)).empty? ||  week_days_updated?(week, self) || new_min_capacity != self.min_capacity || new_max_capacity != self.max_capacity)
        new_meal = self.dup
        new_meal.picture = self.picture
        if new_meal.update_attributes(:meal_name => new_meal_name, :sub_menu_id => new_sub_menu_id, 
          :description => new_description, :is_veg => new_is_veg, :cuisine => new_cuisine,  :spicey_level => new_spicey_level,
          :kitchen_price => new_kitchen_price, :serving_size => new_serving_size, :status => new_status,
          :min_capacity => new_min_capacity, :max_capacity => new_max_capacity, 
          :original_id => ( o_id =  self.original_id ).present? ? o_id : self.id )
            
                self.update_attributes(:status => MEAL_STATUS_INACTIVE, :is_deleted => true)
          
                dishes.each {|dish_id| new_meal.meal_dishes.build(:dish_id => dish_id).save } if dishes.present?
                new_meal.build_week(new_week_days)
                new_meal.save
                new_meal.add_meal_to_default_meal_category
                return new_meal
        end
    else
        self.update_attributes(:meal_name => new_meal_name, :sub_menu_id => new_sub_menu_id, 
          :description => new_description, :is_veg => new_is_veg, :cuisine => new_cuisine,  :spicey_level => new_spicey_level,
          :kitchen_price => new_kitchen_price, :serving_size => new_serving_size, :status => new_status,
          :min_capacity => new_min_capacity, :max_capacity => new_max_capacity)
        self.build_week(new_week_days)
        self.save
        return self  
    end
  end
  
  def week_days_updated?(week, current)
    week = Week.new(week)
    if week[:sunday] != current.week.sunday || week[:monday] != current.week.monday || week[:tuesday] != current.week.tuesday || week[:wednesday] != current.week.wednesday ||week[:thursday] != current.week.thursday || week[:friday] != current.week.friday || week[:saturday] != current.week.saturday
        return true
    else
        return false
    end    
  end
  
  def calculate_total_cost_for_meal
      meal_categories = self.meal_categories.where(:status => MEAL_STATUS_ACTIVE) 
      meal_categories.each do |meal_category|
         meal = meal_category.meal 
         rc_total_price = meal_category.category.packaging_price + meal.kitchen_price + meal.sub_menu.sub_menu_packaging_price
          meal_category.update_attributes(:rc_total_price => rc_total_price)
      end if meal_categories.present?
  end
  
  def self.text_search(query, user_criteria, advance_options)
    basic_search_conditions = {"kitchens.status" => KITCHEN_STATUS_ACTIVATED, "meal_categories.status" => :active}.reject { |k, v| v.nil? }
    user_conditions = {"addresses.city" => user_criteria[:city].present? ? City.find(user_criteria[:city]).city_name.downcase : DEFAULT_SEARCH_CITY_NAME.downcase, "menus.menu_name" => user_criteria[:menu], "kitchens.delivery_zone_id" => ((user_criteria[:area_id].present? && user_criteria[:menu] == MENU_NAME_DINNER) ? Area.find(user_criteria[:area_id]).delivery_zone.id : nil), user_criteria[:delivery_date].present? ? "weeks.#{user_criteria[:delivery_date].to_time.strftime('%A').downcase}" : nil => true }.reject {|k, v| v.nil? || k.nil?}
    adv_search_conditions = {"meals.is_veg" => (advance_options[:veg_non_veg] if advance_options[:veg_non_veg].present?), "meals.cuisine"  => (advance_options[:cuisines] if advance_options[:cuisines].present?),
       "meals.sub_menu_id" => (advance_options[:sub_menu_ids] if advance_options[:sub_menu_ids].present?), 
       "meals.spicey_level" => (advance_options[:spicy_levels] if advance_options[:spicy_levels].present?) }.reject { |k, v| v.nil? } if advance_options.present?
    
    query_result = joins({:kitchen => {:user => :addresses}}, :meal_categories).where("meal_categories.status @@ :d AND kitchens.status @@ :s AND (addresses.area @@ :q or meal_name @@ :q OR meals.description @@ :q OR cuisine @@ :q OR spicey_level @@ :q OR kitchens.kitchen_name @@ :q)", d: :active, s: KITCHEN_STATUS_ACTIVATED, q: query).uniq  if query.present? 

    if advance_options.present?
      result = joins({:kitchen => {:user => :addresses}}, :meal_categories, :week, {:sub_menu => :menu}).where( basic_search_conditions.merge(user_conditions).merge(adv_search_conditions) ).uniq
    else
      result = joins({:kitchen => {:user => :addresses}}, :meal_categories, :week, {:sub_menu => :menu}).where( basic_search_conditions.merge(user_conditions) ).uniq                         
    end
    
    if query.present?
      query_result.merge(result)
    else
      result
    end

  end
  
  def get_meal_categories
      categories = []
      if self.categories.present?
         self.categories.each do |c|
           categories << c.category_name.titleize
         end 
      end
      categories
  end
  
  def get_low_price_meal_category
      pp = self.categories.minimum("packaging_price") if self.categories.present?
      self.categories.find_by_packaging_price(pp) if pp.present?
  end
  
  def is_meal_active?
     return (self.status == MEAL_STATUS_ACTIVE) ? true : false  
  end 
  
  def inactivate_all_meal_categories_except_standard
    meal_categories = self.meal_categories
    meal_categories.each { |meal_category| meal_category.update_attributes(:status => MEAL_STATUS_INACTIVE) if meal_category.category.category_name != STANDARD_MEAL_CATEGORY } if meal_categories.present?
  end
  
  def min_available_capacity
      kitchen = Kitchen.find(self.kitchen_id)
      menu_id = self.sub_menu.menu_id
      k_size_limits = kitchen.kitchen_size_limits.where(:menu_id => menu_id)
      
      return 0 if !k_size_limits.present? # if kitchen not selected any size_limit for party 
      
      size_limit_min = k_size_limits.first.size_limit.min_limit  
      
      k_size_limits.each do |ksl|
        sl = ksl.size_limit        
        size_limit_min = sl.min_limit if size_limit_min > sl.min_limit
      end       
      return size_limit_min
      #TODO lot of discussion required
  end
  
  def max_available_capacity(delivery_date, basket)
    kitchen = Kitchen.find(self.kitchen_id)
    menu_id = self.sub_menu.menu_id
    
    ledger_items = kitchen.ledgers.where(:menu_id => menu_id ).where('sold_date BETWEEN ? AND ?', delivery_date.to_date.beginning_of_day, delivery_date.to_date.end_of_day )
    cancel_items = kitchen.canceled_orders.where(:menu_id => menu_id ).where('sold_date BETWEEN ? AND ?', delivery_date.to_date.beginning_of_day, delivery_date.to_date.end_of_day )
    
    sold_qty = 0
    canceled_qty = 0
    ledger_items.each {|i| sold_qty += i.sold_qty }
    cancel_items.each {|i| canceled_qty += i.canceled_qty }
    
    k_size_limits = kitchen.kitchen_size_limits.where(:menu_id => menu_id)
    
    size_limit_max = 0
    k_size_limits.each do |ksl|
      sl = ksl.size_limit
      size_limit_max = sl.max_limit  if size_limit_max < sl.max_limit  
    end
  
    meal_qty_in_basket = 0
    basket.line_items.each do |li|
      meal_qty_in_basket = meal_qty_in_basket + li.quantity  if li.meal_category.meal.kitchen_id == kitchen.id
    end if basket.present?  
   
    available_capacity =  size_limit_max - (sold_qty - canceled_qty) - meal_qty_in_basket
    available_capacity < 0 ? 0 : available_capacity 
    #TODO lot of discussion required
  end
  
  def available_days
      days = nil
      week = self.week
      if !(week.nil?)
        days = []
        days << 'Sunday' if week.sunday == true
        days << 'Monday' if week.monday == true
        days << 'Tuesday' if week.tuesday == true
        days << 'Wednesday' if week.wednesday == true
        days << 'Thursday' if week.thursday == true
        days << 'Friday' if week.friday == true
        days << 'Saturday' if week.saturday == true
      end
      return days
  end
  
  def exist_orders?
    meal_categories = self.meal_categories
    flag = false
      meal_categories.each do | meal_category |
        if meal_category.orders.present?
          flag = true
        end  
      end if meal_categories.present?
      return flag
  end

  def add_meal_to_default_meal_category
   # add meal to default meal category(service_offerings)
    category_id = Category.where(:category_name => STANDARD_MEAL_CATEGORY, :menu_id => self.sub_menu.menu.id).pluck('id').first
    MealCategory.create(:meal_id => self.id, :category_id => category_id, :status=> self.status )
    self.calculate_total_cost_for_meal
   # end  
  end
  
  def change_default_meal_category_status
    category_id = Category.where(:category_name => STANDARD_MEAL_CATEGORY, :menu_id => self.sub_menu.menu.id).pluck('id').first
    meal_cat = self.meal_categories.where(:category_id => category_id)
    MealCategory.find(meal_cat).update_attributes(:status => self.status)
    self.calculate_total_cost_for_meal
  end
  
  def meal_present_and_active_in_category? (category_id)
    return (self.meal_categories.where(:category_id => category_id, :status => MEAL_STATUS_ACTIVE)).present? ? true : false
  end
end
