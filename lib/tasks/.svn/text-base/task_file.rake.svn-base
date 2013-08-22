task :create_test_kitchen  => :environment do
  
  puts "*** CREATING TEAMS & EMPLOYEES..... ***"
    # ------------------------------ Teams ------------------------------
    t1 = Team.create(:team_name => 'Management', :team_description => 'The RasoiClub Mangement Team', :team_type => TEAM_TYPE_MANAGEMENT)
    t2 = Team.create(:team_name => 'Admin Team', :team_description => 'The RasoiClub Admin Team', :team_type => TEAM_TYPE_ADMIN)
    t3 = Team.create(:team_name => 'Account Team', :team_description => 'The RasoiClub Account Team', :team_type => TEAM_TYPE_ACCOUNT)
    t4 = Team.create(:team_name => 'Operations Team', :team_description => 'The RasoiClub Operation Team', :team_type => TEAM_TYPE_OPERATION)
  
    # ------------------------------ Employees ------------------------------
    e = Employee.new(:first_name=>'Raj1', :last_name=>'Lalwani', :middle_name=>'R', :primary_email_id =>'raj@lalwani.com', :primary_mobile_number=>'9922992299')
    e.user = User.new(:first_name => e.first_name, :middle_name  => e.middle_name, :last_name => e.last_name, :primary_email_id => e.primary_email_id, :primary_mobile_number => e.primary_mobile_number, :terms_conditions => true, :user_type => USER_TYPE_EMPLOYEE)  
    e.user.login = Login.new(:user_name => e.primary_email_id)
    e.user.login.password_confirmation = e.user.login.password = 'password123'
    e.save

    t1.employees << e
    
    e = Employee.new(:first_name=>'Raj2', :last_name=>'Lalwani', :middle_name=>'R', :primary_email_id =>'raj2@lalwani.com', :primary_mobile_number=>'9922992299')
    e.user = User.new(:first_name => e.first_name, :middle_name  => e.middle_name, :last_name => e.last_name, :primary_email_id => e.primary_email_id, :primary_mobile_number => e.primary_mobile_number, :terms_conditions => true, :user_type => USER_TYPE_EMPLOYEE)
    e.user.login = Login.new(:user_name => e.primary_email_id)
    e.user.login.password_confirmation = e.user.login.password = 'password123'
    e.save
  
    t2.employees << e
    
    e = Employee.new(:first_name=>'Raj3', :last_name=>'Lalwani', :middle_name=>'R', :primary_email_id =>'raj3@lalwani.com', :primary_mobile_number=>'9922992299')
    e.user = User.new(:first_name => e.first_name, :middle_name  => e.middle_name, :last_name => e.last_name, :primary_email_id => e.primary_email_id, :primary_mobile_number => e.primary_mobile_number, :terms_conditions => true, :user_type => USER_TYPE_EMPLOYEE)
    e.user.login = Login.new(:user_name => e.primary_email_id)
    e.user.login.password_confirmation = e.user.login.password = 'password123'
    e.save
    
    t3.employees << e
  
    e = Employee.new(:first_name=>'Raj4', :last_name=>'Lalwani', :middle_name=>'R', :primary_email_id =>'raj4@lalwani.com', :primary_mobile_number=>'9922992299')
    e.user = User.new(:first_name => e.first_name, :middle_name  => e.middle_name, :last_name => e.last_name, :primary_email_id => e.primary_email_id, :primary_mobile_number => e.primary_mobile_number, :terms_conditions => true, :user_type => USER_TYPE_EMPLOYEE)
    e.user.login = Login.new(:user_name => e.primary_email_id)
    e.user.login.password_confirmation = e.user.login.password = 'password123'
    e.save
    
    t4.employees << e

  puts "*** CREATED SUCCESSFULLY ***\n\n"
  
  puts '*** Default Kitchens ***'
    # --------------------------Default Kitchen------------------------
    dz = DeliveryZone.find_by_name('baner-balewadi')
    k = Kitchen.new(:kitchen_name => 'Mrs. Guptas Kitchen',
                    :primary_contact_name => 'prem',
                    :last_name => 'khurana',
                    :primary_contact_number => '1234567890',
                    :primary_email_id => 'a@b.com',
                    :agreement => true,
                    :cuisine_style => 'south indian',
                    :status => KITCHEN_STATUS_ACTIVATED,
                    :delivery_zone_id => dz.id
                  )
    k.user = k.build_user(
                    :first_name => k.primary_contact_name,
                    :last_name => k.last_name,
                    :primary_email_id => k.primary_email_id,
                    :alternate_email_id => k.alternative_email_id,
                    :primary_mobile_number => k.primary_contact_number,
                    :alternate_contact_number => k.alternative_contact_number,
                    :terms_conditions => true,
                    :user_type => USER_TYPE_KITCHEN
                  )
    k.user.alternate_contact_number = k.alternative_contact_number if k.alternative_contact_number.present?
    k.user.alternate_email_id = k.alternative_email_id if k.alternative_email_id.present?
    
    k.user.login = Login.new(:user_name => k.primary_email_id)
    k.user.login.password_confirmation = k.user.login.password = 'password123'
    
    address = k.user.addresses.build(
                                    :line1 => "Gulmohar", :area => "baner", :city => "pune",
                                    :state => "Maharashtra", :country => "India", :pincode => 411045)
    #k.assign_delivery_zone(address.area, address.pincode)
    
    menu = Menu.find_by_menu_name(MENU_NAME_DINNER)
    size_limit = SizeLimit.find(:first, :conditions  => [ 'min_limit = ? AND max_limit = ?', MENU_DINNER_LOWER_LIMIT, MENU_DINNER_UPPER_LIMIT ])
    k.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => size_limit.id)
    k.add_default_party_size_limit
    k.save
  puts "*** CREATED SUCCESSFULLY ***\n\n"
end

task :test_kitchen_cut_off_hours  => :environment do
  puts "**************start***************"
    k = Kitchen.find_by_primary_email_id('a@b.com')
    if k.present?
      cut_off_hour1 = k.kitchen_cut_off_hours.build(:menu_id => 1, :cut_off_hour_id => 1)
      cut_off_hour2 = k.kitchen_cut_off_hours.build(:menu_id => 2, :cut_off_hour_id => 4)
      cut_off_hour3 = k.kitchen_cut_off_hours.build(:menu_id => 3, :cut_off_hour_id => 4)
    end
    k.save
     puts "**************end***************"
end    