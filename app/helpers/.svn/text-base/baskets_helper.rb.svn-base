module BasketsHelper
  include ApplicationHelper

  def get_validation_flags
     return flag = {:city_mismatch_flag => false,
                    :kitchen_close_flag => false,
                    :menu_mismatch_flag => false,
                    :area_mismatch_flag => false,
                    :delivery_date_mismatch_flag => false,
                    :already_present_flag => false, 
                    :cut_off_hrs_mismatch_flag => false,
                    :less_than_min_capacity => false,       
                    :greater_than_max_capacity => false 
                   }
  end
  
  
  def meal_category_validation(meal_category, qty, new_item)    
              flag = get_validation_flags
        user_input = get_user_input_session
              meal = meal_category.meal
           kitchen = meal.kitchen
              city = kitchen.user.addresses.first.city
          sub_menu = meal.sub_menu
              menu = sub_menu.menu 
    available_days = meal.available_days
    max_capacity = nil
    if meal_category.present?
      if !kitchen.is_open
          flag[:kitchen_close_flag] = true
      elsif city.casecmp( (c = City.find(user_input[:city])).present? ? c.city_name : "City Not Avilable" ) != 0
          flag[:city_mismatch_flag] = true  
      elsif menu.menu_name.casecmp(MENU_NAME_DINNER) == 0 && user_input[:area_id].present? && ( !kitchen.delivery_zone_id.present? ? true : (kitchen.delivery_zone_id != Area.find( user_input[:area_id] ).delivery_zone_id ) )
          flag[:area_mismatch_flag] = true
      elsif menu.menu_name.casecmp(user_input[:menu]) != 0
          flag[:menu_mismatch_flag] = true
      elsif (available_days.present? ) && !(available_days.include?( ( user_input[:delivery_date].present? ? user_input[:delivery_date].to_time.strftime('%A') : "Not Available")  ) )
          flag[:delivery_date_mismatch_flag] = true
      elsif ( DateTime.now >= kitchen.notice_time( user_input[:delivery_date].to_time, meal.sub_menu.menu_id, user_input[:delivery_time] ) )
          flag[:cut_off_hrs_mismatch_flag] = true
      elsif meal.min_available_capacity > qty.to_i
          flag[:less_than_min_capacity]  = true 
      elsif (max_capacity = meal.max_available_capacity(session[:user_input][:delivery_date].to_time, new_item ? get_current_basket : nil)) < qty.to_i 
          flag[:greater_than_max_capacity] = true
      end
    end  
    
    return flag, max_capacity
  end
  
  
  def already_present_check( meal_category_id, flag )
    basket = get_current_basket
    basket_items = basket.line_items if basket.present?
    
    if basket_items.present?
       basket_items.each do |f|
         if(f.meal_category_id == meal_category_id)
           flag[:already_present_flag] = true
           break
         end
       end 
    end
    
    return flag
  end 
  
  
  def valid_to_add_in_basket?( meal_category_id, qty )
    meal_category = MealCategory.find(meal_category_id)
    
    flag, max_capacity = meal_category_validation( meal_category, qty, true )     #TODO: Code needs to refine for modularity
    flag = already_present_check( meal_category_id, flag )
    
    if flag.all? {|k, v| v != true }
      return true, "Added Successfully."
    else
      return false, get_error_message( flag, meal_category.meal, max_capacity )   
    end
  end
  
  
  def validate_existing_basket_items
     basket = get_current_basket
     error_hash = Hash.new
     basket.line_items.each do |line_item|
       
        flag, max_capacity = meal_category_validation( line_item.meal_category, line_item.quantity, false )  #for validation of meal category present in basket
       
        line_item.update_attributes(:is_valid => true)
        if !flag.all? {|k, v| v != true }
          line_item.update_attributes(:is_valid => false)
          message = get_error_message( flag, line_item.meal_category.meal, max_capacity )
          error_hash["#{ line_item .id }"] = message     
        end
     end if basket.present?
     return error_hash
  end
  
  
  def get_error_message( flag, meal, max_capacity)
    if flag[:kitchen_close_flag]
      return "Kitchen is closed."
    elsif flag[:menu_mismatch_flag]
      return "Menu Mismatch."
    elsif flag[:area_mismatch_flag]
      return "Delivery area mismatch."
    elsif flag[:delivery_date_mismatch_flag]
      return "Dish unavailable for the selected delivery date."   
    elsif flag[:cut_off_hrs_mismatch_flag]
      return "Order window for the selected date is closed. Please select either a different dish or change the selected date."
    elsif flag[:already_present_flag]
      return "Already present in your Basket."
    elsif flag[:city_mismatch_flag] 
      return "Sorry! you can not add dishes of different cities."
    elsif flag[:less_than_min_capacity]
      return "Quantity should be greater than the minimum order size (which is " + (meal.min_available_capacity).to_s + ")."  
    elsif flag[:greater_than_max_capacity]
      return "Quantity should be less than the available stock (" + max_capacity.to_s + " available)." if max_capacity.present?
      return "Meal is Out Of Stock." if !max_capacity.present?
    else
      return "Added Successfully."
    end   
  end
  

  def update_basket(basket)
      basket.total_quantity = basket.line_items.present? ? basket.line_items.sum(:quantity) : 0
      basket.sub_total = basket.line_items.present? ? basket.line_items.sum(:total_price) : 0
      basket.total_tax = ((basket.sub_total * 0)/100)   # TODO: When tax gets implemented change zero to actual value from database
      basket.delivery_charge = (basket.sub_total * get_delivery_charge_percentage(basket))/100  
      basket.grand_total = basket.sub_total + basket.total_tax + basket.delivery_charge  
      basket.save
  end
  
  
  def get_delivery_charge_percentage(basket)
    user_area = Area.find(session[:user_input][:area_id].to_i) if session[:user_input].present? && session[:user_input][:area_id].present?
  
    if basket.contain_different_delivery_zone? || (!basket.contain_different_delivery_zone? && basket.get_delivery_zone.present? && (!user_area.present? || (user_area.present? && (basket.get_delivery_zone.id != user_area.delivery_zone.id))))
      return HIGH_DELIVERY_CHARGE_PERCENTAGE
    else
      return LOW_DELIVERY_CHARGE_PERCENTAGE
    end
      
  end
  
  def validate_and_add_line_item( meal_category_id, qty )
    result, message = valid_to_add_in_basket?(meal_category_id, qty)

    if result
      basket = get_current_basket
      LineItem.create(:basket_id => basket.id, :meal_category_id => meal_category_id, :quantity => qty)
      update_basket(basket)
    end
    delete_item_from_session if session[:item_to_be_added_in_basket].present?
    return result, message
  end  
end
