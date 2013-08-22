module KitchensHelper
  
  def get_party_min_max_serving_size kitchen_id
    kitchen = Kitchen.find( kitchen_id )
    party_menu = Menu.find_by_menu_name(MENU_NAME_PARTY)

    k_size_limits = kitchen.kitchen_size_limits.where( :menu_id => party_menu.id)
    
    return 0, 0 if !k_size_limits.present? # if kitchen not selected any size_limit for party 
    
    size_limit_min = k_size_limits.first.size_limit.min_limit  
    size_limit_max = k_size_limits.first.size_limit.max_limit
    
    k_size_limits.each do |ksl|
      sl = ksl.size_limit        
      size_limit_min = sl.min_limit if size_limit_min > sl.min_limit
      size_limit_max = sl.max_limit if size_limit_max < sl.max_limit
    end       
    return size_limit_min, size_limit_max 
  end
  
end
