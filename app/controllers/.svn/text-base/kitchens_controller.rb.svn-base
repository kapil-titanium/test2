
class KitchensController < ApplicationController
  load_and_authorize_resource
  
  def index
      @employee = Employee.find(current_user.employee) if current_user.employee.present?
      @kitchens = Kitchen.order('id asc').all
  end
  
  def show
    @kitchen = Kitchen.find(params[:id])
    @meals = @kitchen.meals.order('id')
    @meals = @meals.page(params[:page]) if @meals.present?
    @orders = @kitchen.child_orders.open_kitchen_orders.order('delivery_date asc') if @kitchen.child_orders.present?
  end
  
  def new
      @kitchen = Kitchen.new
      user = @kitchen.build_user
      @address = user.addresses.build
      @areas = Area.all #Area.pluck(:area_name)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @kitchen }
      end
  end
  
  def create
      @kitchen = Kitchen.new(params[:kitchen])
      @kitchen.user = User.new(:first_name => @kitchen.primary_contact_name, 
                                :last_name => @kitchen.last_name, 
                                :primary_email_id => @kitchen.primary_email_id, 
                                :primary_mobile_number => @kitchen.primary_contact_number,
                                :terms_conditions => true, 
                                :user_type => USER_TYPE_KITCHEN)
      
      @kitchen.user.alternate_contact_number = @kitchen.alternative_contact_number if @kitchen.alternative_contact_number.present?
      @kitchen.user.alternate_email_id = @kitchen.alternative_email_id if @kitchen.alternative_email_id.present?
      
      @kitchen.user.login = Login.create_login(@kitchen.primary_email_id, generate_password)
      
      address = @kitchen.user.addresses.build(params[:user][:address])
      @kitchen.assign_delivery_zone(address.area, address.pincode)
      
      menu = Menu.find_by_menu_name(MENU_NAME_DINNER)
      size_limit = SizeLimit.find(:first, :conditions  => [ 'min_limit = ? AND max_limit = ?', MENU_DINNER_LOWER_LIMIT, MENU_DINNER_UPPER_LIMIT ])
      @kitchen.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => size_limit.id)
      
      @kitchen.add_default_party_size_limit
      @kitchen.set_default_kitchen_cut_off_hours
      if @kitchen.save
         UserMailer.kitchen_registration_confirmation(@kitchen).deliver
         UserMailer.registration_password_confirmation(@kitchen.user.login).deliver if @kitchen.user.present?
         flash[:notice] = "You are registered Successfully. Your login details are send to your registered mail id."
         redirect_to new_login_path(@kitchen)
      else
         render action: "new"
      end
  end
  
  def edit
      @kitchen = Kitchen.find(params[:id])
      @address = @kitchen.user.addresses.present? ? @kitchen.user.addresses.first : @kitchen.user.addresses.build
      @areas = Area.all #pluck(:area_name)
  end
  
  def update
      @kitchen = Kitchen.find(params[:id])
      user = @kitchen.user
      user.first_name = params[:kitchen][:primary_contact_name]
      user.last_name = params[:kitchen][:last_name]
      user.alternate_email_id = params[:kitchen][:alternative_email_id] 
      user.primary_mobile_number = params[:kitchen][:primary_contact_number]
      user.alternate_contact_number = params[:kitchen][:alternative_contact_number]
      address = user.addresses.present? ? user.addresses.first : user.addresses.build
      address.attributes = params[:user][:address]
      @kitchen.assign_delivery_zone(address.area, address.pincode)
      if @kitchen.update_attributes(params[:kitchen])
         if user.save
           address.save
         end
         redirect_to kitchen_path(@kitchen)
      else
        render action: 'edit'
      end
  end
  
  def profile_setting
    @kitchen = Kitchen.find(params[:kitchen_id])
    @sizes = SizeLimit.find(:all, :conditions => [ 'min_limit != ? AND max_limit != ?', MENU_DINNER_LOWER_LIMIT, MENU_DINNER_UPPER_LIMIT ])
    available_limit_ids = @kitchen.size_limits.select("size_limits.id").where('min_limit != ? AND max_limit != ?', MENU_DINNER_LOWER_LIMIT, MENU_DINNER_UPPER_LIMIT ) if @kitchen.size_limits.present?
    @available_limit_ids = []
    available_limit_ids.each do |limit_id|
      @available_limit_ids << limit_id[:id]
    end
    
    menu_id = Menu.find_by_menu_name(MENU_NAME_DINNER).id
    @dinner_cut_off_hours = CutOffHour.where(:menu_id => menu_id)
    menu_id = Menu.find_by_menu_name(MENU_NAME_PARTY).id
    @party_and_treat_cut_off_hours = CutOffHour.where(:menu_id => menu_id)
  end
  
  def save_profile_setting
      @kitchen = Kitchen.find(params[:kitchen_id])
      menu = Menu.find_by_menu_name(MENU_NAME_PARTY)
      @kitchen.create_kitchen_size_limit(params[:party_sizes], menu)
      @kitchen.update_kitchen_cut_off_hours(params)
      redirect_to kitchen_path(@kitchen)
  end
  
  def get_current_orders
    @kitchen = Kitchen.find(params[:kitchen_id])
    @orders = @kitchen.child_orders.open_kitchen_orders.order('delivery_date asc')
    render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  def get_orders_history
    @kitchen = Kitchen.find(params[:kitchen_id])
    @orders = @kitchen.child_orders.order('delivery_date desc').kitchen_order_history
    render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  #-----------------------------TO OPEN OR CLOSE KITCHEN------------------ 
  def kitchen_open_close
    @kitchen = Kitchen.find(params[:kitchen_id])
    @kitchen.update_attributes(:is_open => @kitchen.is_open ? false : true ) if @kitchen.present?
    render :partial => 'kitchen_header', :locals => {:kitchen => @kitchen}
  end
  
  #-----------------------------Kitchens: Access to employee only------------------
  def get_kitchens
      @kitchens = Kitchen.order('id asc').all
      render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => nil }
  end
  
  def new_registrations
     active_cities = City.get_active_cities
     @kitchens = Kitchen.new_registrations
     render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => active_cities }
  end
  
  def unapproved
      active_cities = City.get_active_cities
      @kitchens = Kitchen.joins(:user => :addresses).where("kitchens.status = ? AND LOWER(addresses.city) IN (?)", KITCHEN_STATUS_NEW, active_cities)
      render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => active_cities }
  end
  
  # def approved
    # authorize! :approved, Kitchen
    # @approved_kitchens = Kitchen.approved    
  # end
  
  def rejected
    @kitchens = Kitchen.rejected
    render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => nil }    
  end
  
  def to_be_activated
    @kitchens = Kitchen.to_be_activated
    render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => nil }
  end  
  
  def activated
    @kitchens = Kitchen.activated
    render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => nil }
  end
  
  def suspend
    @kitchens = Kitchen.suspended
    render :partial => '/kitchens/change_status', :locals => { :kitchens => @kitchens, :active_cities => nil }    
  end
  
  def change_status
    # TODO: Implement User Mailer
    kitchen = Kitchen.find(params[:id])
    if params[:commit].casecmp(KITCHEN_BUTTON_APPROVE) == 0
       UserMailer.kitchen_approval(kitchen).deliver if kitchen.update_attributes(:status => KITCHEN_STATUS_APPROVED, :status_comment => params[:status_comment], :status_changed_by => current_user.id, :status_changed_on => DateTime.now)
        
    end
    if params[:commit].casecmp(KITCHEN_BUTTON_REJECT) == 0       
       UserMailer.kitchen_rejection(kitchen).deliver if kitchen.update_attributes(:status => KITCHEN_STATUS_REJECTED, :status_comment => params[:status_comment], :status_changed_by => current_user.id, :status_changed_on => DateTime.now)
        
    end
    if params[:commit].casecmp(KITCHEN_BUTTON_ACTIVATE) == 0
       UserMailer.kitchen_activation(kitchen).deliver if kitchen.update_attributes(:status => KITCHEN_STATUS_ACTIVATED, :status_comment => params[:status_comment], :status_changed_by => current_user.id, :status_changed_on => DateTime.now)
        
    end
    if params[:commit].casecmp(KITCHEN_BUTTON_SUSPEND) == 0
       UserMailer.kitchen_suspend(kitchen).deliver if kitchen.update_attributes(:status => KITCHEN_STATUS_SUSPENDED, :status_comment => params[:status_comment], :status_changed_by => current_user.id, :status_changed_on => DateTime.now)
        
    end 
    if params[:commit].casecmp(KITCHEN_BUTTON_SUBMIT) == 0
      if kitchen.validate_presence_of_comment(params[:status_comment])
        UserMailer.kitchen_suspend(kitchen).deliver if kitchen.update_attributes(:status_comment => params[:status_comment])
          
      end 
    end
    redirect_to :back
  end
  
end
