puts "*********************************************by using xslx********************"
puts "***************************************by using test1.xslx*******************"
file = ("public/test1.xlsx")
s = Roo::Excelx.new(file)
s.sheets.each do |sheet|
  if sheet.upcase == 'MENU'
    puts "\n*************************Menu Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        menu_name = s.cell(trav_row, trav_col).downcase
        description  = s.cell(trav_row, trav_col + 1 )
        menu = Menu.new(:menu_name => menu_name, :description => description)
        menu.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End Of Menu Creation ***************"
  end

  if sheet.upcase == 'SUB_MENU'
    puts "\n************** Sub Menu Creation ****************************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        menu_name = s.cell(trav_row, trav_col).downcase
        sub_menu_name = s.cell(trav_row, trav_col + 1).downcase
        description  = s.cell(trav_row, trav_col + 2 )
        kitchen_price_range_min = s.cell(trav_row, trav_col + 3 )
        kitchen_price_range_max = s.cell(trav_row, trav_col + 4 )
        packaging_price = s.cell(trav_row, trav_col + 5 )
        menu = Menu.find_by_menu_name(menu_name)
        menu.sub_menus.build(:sub_menu_name => sub_menu_name, :description => description, :rc_price_range_min => kitchen_price_range_min,
        :rc_price_range_max => kitchen_price_range_max, :sub_menu_packaging_price => packaging_price )
        menu.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End Of SubMenu Creation ***************"
  end

  if sheet.upcase == 'SERVICE_OFFERINGS'
    puts "\n**************SERVICE_OFFERINGS Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        menu_name = s.cell(trav_row, trav_col).downcase
        category_name = s.cell(trav_row, trav_col + 1).downcase
        description  = s.cell(trav_row, trav_col + 2 )
        packaging_price = s.cell(trav_row, trav_col + 3 )

        menu = Menu.find_by_menu_name(menu_name)
        menu.categories.build(:category_name => category_name, :description => description, :packaging_price => packaging_price)
        menu.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of SERVICE_OFFERINGS Creation ***************"
  end

  if sheet.upcase == 'COURSES'
    puts "\n**************COURSES Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        course_name = s.cell(trav_row, trav_col).downcase
        description  = s.cell(trav_row, trav_col + 1 )

        course = Course.new(:course_name => course_name, :description => description)
        course.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End Of COURSES Creation ***************"
  end

  if sheet.upcase == 'SUB_MENU_COURSE_CRITERIA'
    puts "\n**************SUB_MENU_COURSE_CRITERIA Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        sub_menu_name = s.cell(trav_row, trav_col).downcase
        course_name = s.cell(trav_row, trav_col + 1).downcase
        min_qty =  s.cell(trav_row, trav_col + 2)
        max_qty =  s.cell(trav_row, trav_col + 3)

        sub_menu = SubMenu.find_by_sub_menu_name(sub_menu_name)
        course = Course.find_by_course_name(course_name)

        sMCI = SubMenuCourseInfo.new(:sub_menu_id => sub_menu.id, :course_id => course.id, :min_qty => min_qty, :max_qty => max_qty)
        sMCI.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of SUB_MENU_COURSE_CRITERIA Creation ***************"
  end

  if sheet.upcase == 'CITY'
    puts "\n**************CITY Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        city_name = s.cell(trav_row, trav_col).downcase
        city_code = s.cell(trav_row, trav_col + 1)
        state =  s.cell(trav_row, trav_col + 2)
        country =  s.cell(trav_row, trav_col + 3)
        status =  s.cell(trav_row, trav_col + 4).downcase

        city = City.new(:city_name => city_name, :city_code => city_code, :state => state, :country => country, :status => status)
        city.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of  Creation ***************"
  end

  if sheet.upcase == 'DELIVERY_ZONE'
    puts "\n**************DELIVERY_ZONE Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        city_name = s.cell(trav_row, trav_col).downcase
        delivery_zone_name = s.cell(trav_row, trav_col + 1).downcase
        status =  s.cell(trav_row, trav_col + 2).downcase
        base_time =  s.cell(trav_row, trav_col + 3)
        city = City.find_by_city_name(city_name)
        dz = DeliveryZone.new(:city_id => city.id, :name => delivery_zone_name, :status => status, :base_time => base_time)
        dz.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of DELIVERY_ZONE Creation ***************"
  end

  if sheet.upcase == 'AREAS'
    puts "\n**************AREAS Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        delivery_zone_name = s.cell(trav_row, trav_col).downcase
        area_name =  s.cell(trav_row, trav_col + 1).downcase
        pincode =  s.cell(trav_row, trav_col + 2)
        status =  s.cell(trav_row, trav_col + 3).downcase

        dz = DeliveryZone.find_by_name(delivery_zone_name)

        area = Area.new(:delivery_zone_id => dz.id, :area_name => area_name, :pincode => pincode, :status => status)
        area.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of AREAS Creation ***************"
  end

  if sheet.upcase == 'SIZE_LIMIT'
    puts "\n**************SIZE_LIMIT Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        min_limit = s.cell(trav_row, trav_col)
        max_limit =  s.cell(trav_row, trav_col + 1)

        SizeLimit.create(:min_limit => min_limit, :max_limit => max_limit)
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of SIZE_LIMIT Creation ***************"
  end

end
puts "************************************End by using test1.xslx********************************"

puts "************************************by using test2.xslx***********************************"

file = ("public/test2.xlsx")
s = Roo::Excelx.new(file)
s.sheets.each do |sheet|

  if sheet.upcase == 'KITCHEN'
    puts "\n**************KITCHEN Creation ***************"
    begin
      s.default_sheet = sheet

      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_name = s.cell(trav_row, trav_col)
        primary_contact_name = s.cell(trav_row, trav_col + 1)
        last_name = s.cell(trav_row, trav_col + 2)
        primary_contact_number = s.cell(trav_row, trav_col + 3).to_s.chop.chop
        primary_email_id = s.cell(trav_row, trav_col + 4)
        description = s.cell(trav_row, trav_col + 5)
        delivery_zone = s.cell(trav_row, trav_col + 6).downcase
        status = s.cell(trav_row, trav_col + 7).downcase
        is_open = s.cell(trav_row, trav_col + 8)
        term_and_conditions = s.cell(trav_row, trav_col + 9)
        agreement = s.cell(trav_row, trav_col + 10)
        password = s.cell(trav_row, trav_col + 11)
        line1 =  s.cell(trav_row, trav_col + 12)
        area = s.cell(trav_row, trav_col + 13).downcase
        city = s.cell(trav_row, trav_col + 14).downcase
        state = s.cell(trav_row, trav_col + 15)
        country = s.cell(trav_row, trav_col + 16)
        pincode = s.cell(trav_row, trav_col + 17)
        dz = DeliveryZone.find_by_name(delivery_zone)
        k = Kitchen.new(:kitchen_name => kitchen_name,
        :primary_contact_name => primary_contact_name,
        :last_name => last_name,
        :primary_contact_number => primary_contact_number.to_s,
        :primary_email_id => primary_email_id,
        :agreement => 'true',
        :cuisine_style => 'south indian',
        :status => status,
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
        k.user.login.password_confirmation = k.user.login.password = password
        address = k.user.addresses.build(
        :line1 => line1, :area => area, :city => city,
        :state => state, :country => country, :pincode => pincode)
        k.assign_delivery_zone(address.area, address.pincode)
        menu = Menu.find_by_menu_name(MENU_NAME_DINNER)
        
        size_limit = SizeLimit.find(:first, :conditions  => [ 'min_limit = ? AND max_limit = ?', MENU_DINNER_LOWER_LIMIT, MENU_DINNER_UPPER_LIMIT ])
        k.kitchen_size_limits.build(:menu_id => menu.id, :size_limit_id => size_limit.id)
       
        k.add_default_party_size_limit   
       
        k.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of KITCHEN Creation ***************"
  end

  if sheet.upcase == 'DISH'
    puts "\n**************DISH Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        dish_name =  s.cell(trav_row, trav_col + 1)
        course_type =  s.cell(trav_row, trav_col + 2).downcase
        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        course = Course.find_by_course_name(course_type)
        kitchen.dishes.build(:dish_name => dish_name, :course_id => course.id)

        kitchen.save
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of DISH Creation ***************"
  end

  if sheet.upcase == 'MEAL'
    puts "\n**************MEAL Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        meal_name =  s.cell(trav_row, trav_col + 1)
        menu_name =  s.cell(trav_row, trav_col + 2).downcase
        sub_menu_name =  s.cell(trav_row, trav_col + 3).downcase
        kitchen_price =  s.cell(trav_row, trav_col + 4)
        spicy_level =  s.cell(trav_row, trav_col + 5)
        description =  s.cell(trav_row, trav_col + 6)
        status =  s.cell(trav_row, trav_col + 7).downcase
        serving_size =  s.cell(trav_row, trav_col + 8)
        cuisine =  s.cell(trav_row, trav_col + 9)
        min_capacity =  s.cell(trav_row, trav_col + 10)
        max_capacity =  s.cell(trav_row, trav_col + 11)
        is_veg = s.cell(trav_row, trav_col + 12)

        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        menu = Menu.find_by_menu_name(menu_name)
        sub_menu = SubMenu.find_by_sub_menu_name(sub_menu_name)
        meal = Meal.create(:kitchen_id => kitchen.id, :meal_name => meal_name, :sub_menu_id => sub_menu.id, :kitchen_price => kitchen_price, :spicey_level => spicy_level,
        :description => description, :status => status, :serving_size => serving_size, :cuisine => cuisine,
        :min_capacity => min_capacity, :max_capacity => max_capacity, :is_veg => is_veg)
        meal.add_meal_to_default_meal_category
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of MEAL Creation ***************"
  end
end
puts "************************************End by using test2.xslx***********************************"

puts "************************************by using test3.xslx***********************************"

file = ("public/test3.xlsx")
s = Roo::Excelx.new(file)
s.sheets.each do |sheet|
  if sheet.upcase == 'MEALDISHES'
    puts "\n**************MEALDISHES Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        meal_name =  s.cell(trav_row, trav_col + 1)
        sub_menu_name =  s.cell(trav_row, trav_col + 2).downcase
        dish_name =  s.cell(trav_row, trav_col + 3)
        course_type =  s.cell(trav_row, trav_col + 4).downcase

        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        course = Course.find_by_course_name(course_type)
        sub_menu = SubMenu.find_by_sub_menu_name(sub_menu_name)
        dish = kitchen.dishes.where(:course_id => course.id, :dish_name => dish_name).first

        meal = kitchen.meals.where(:meal_name => meal_name, :sub_menu_id => sub_menu.id).first
        meal.meal_dishes.build(:dish_id => dish.id).save

        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of MEALDISHES Creation ***************"
  end

end
puts "************************************End by using test3.xslx***********************************"

puts "************************************by using test4.xslx***********************************"

file = ("public/test4.xlsx")
s = Roo::Excelx.new(file)
s.sheets.each do |sheet|

  if sheet.upcase == 'AVAILABLE DAYS'
    puts "\n**************Meal Available Days Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        meal_name =  s.cell(trav_row, trav_col + 1)
        sub_menu_name = s.cell(trav_row, trav_col + 2).downcase
        mon =  s.cell(trav_row, trav_col + 3)
        tue =  s.cell(trav_row, trav_col + 4)
        wen =  s.cell(trav_row, trav_col + 5)
        thu =  s.cell(trav_row, trav_col + 6)
        fri =  s.cell(trav_row, trav_col + 7)
        sat =  s.cell(trav_row, trav_col + 8)
        sun =  s.cell(trav_row, trav_col + 9)

        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        sub_menu = SubMenu.find_by_sub_menu_name(sub_menu_name)
        meal = kitchen.meals.where(:meal_name => meal_name, :sub_menu_id => sub_menu.id).first
        meal.build_week(:monday => mon, :tuesday => tue, :wednesday => wen, :thursday => thu,
        :friday => fri, :saturday => sat, :sunday => sun)
        meal.save
        trav_row = trav_row + 1
      end
    end

    puts "\n**************End of Meal Available Days Creation ***************"
  end

  if sheet.upcase == 'MEAL_SERVICE_OFFERINGS'
    puts "\n************** MEAL_SERVICE_OFFERINGS Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        meal_name =  s.cell(trav_row, trav_col + 1)
        sub_menu_name =  s.cell(trav_row, trav_col + 2).downcase
        dish_name =  s.cell(trav_row, trav_col + 3)
        course_type =  s.cell(trav_row, trav_col + 4).downcase

        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        course = Course.find_by_course_name(course_type)
        sub_menu = SubMenu.find_by_sub_menu_name(sub_menu_name)

        dish = kitchen.dishes.where(:course_id => course.id, :dish_name => dish_name)

        meal = kitchen.meals.where(:meal_name => meal_name, :sub_menu_id => sub_menu.id)
        meal.meal_dishes.build(:dish_id => dish.id).save

        trav_row = trav_row + 1
      end
    end
    puts "\n************** End of MEAL_SERVICE_OFFERINGS Creation ***************"
  end

  if sheet.upcase == 'CUT_OFF_HOURS'
    puts "\n************** CUT_OFF_HOURS Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        time = s.cell(trav_row, trav_col)
        menu_name = s.cell(trav_row, trav_col + 1).downcase
        menu = Menu.find_by_menu_name(menu_name)
        CutOffHour.create(:time => time, :menu_id => menu.id)
        trav_row = trav_row + 1
      end
    end
    puts "\n**************End of CUT_OFF_HOURS Creation ***************"
  end

  if sheet.upcase == 'KITCHEN_CUT_OFF_HOURS'
    puts "\n************** KITCHEN_CUT_OFF_HOURS Creation ***************"
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        kitchen_email_id = s.cell(trav_row, trav_col)
        menu_name = s.cell(trav_row, trav_col + 1).downcase
        cut_off_hour = s.cell(trav_row, trav_col + 2)

        kitchen = Kitchen.find_by_primary_email_id(kitchen_email_id)
        menu = Menu.find_by_menu_name(menu_name)
        coh = CutOffHour.find_by_time(cut_off_hour)

        kitchen.kitchen_cut_off_hours.build(:menu_id => menu.id, :cut_off_hour_id => coh.id)
        kitchen.save

        trav_row = trav_row + 1
      end
    end
    puts "\n************** End of KITCHEN_CUT_OFF_HOURS Creation ***************"
  end

end
puts "**********************************end by using test4.xsl*****************************************"
puts "end by using xsl"

