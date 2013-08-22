
class SearchesController < ApplicationController
  #include SearchesHelper

  def index
    if params[:dinner].present?
      params[:commit] = MENU_NAME_DINNER
    elsif params[:party].present?
      params[:commit] = MENU_NAME_PARTY
    elsif params[:featured_kitchen].present?
      reema_kitchen = Kitchen.find_by_primary_email_id("a@b.com")    # ("shrivastav.reema@gmail.com")   #TODO: test flow by Rajul
      redirect_to kitchen_path(reema_kitchen) if reema_kitchen.present?
    end
    
    params[:commit] = nil if (params[:commit].present? && params[:commit].casecmp(REFINE_SEARCH_COMMIT_BUTTON) == 0) 
    save_user_criteria(params[:filter_city].present? ? params[:filter_city] : City.get_default_city_id, params[:commit], params[:delivery_date], params[:area_id_by_area], params[:delivery_time].present? ? params[:delivery_time] : nil )
    
    filter_text = params[:search][:filter_text] if params[:search].present?
    user_criteria = get_user_criteria
    
    @advance_options = get_advance_options if advance_options_available?
    @kitchens = Kitchen.text_search( params[:filter_city].present? ? City.find(params[:filter_city]).city_name : DEFAULT_SEARCH_CITY_NAME, filter_text, @advance_options.present? ? @advance_options : nil)
    @meals = Meal.text_search(filter_text, user_criteria, @advance_options.present? ? @advance_options : nil)    
    kitchens_of_searched_meals = Kitchen.joins(:meals).where(:id => @meals.map{|m| m.kitchen_id}).uniq
    @kitchens.present? ? (@kitchens = (@kitchens + kitchens_of_searched_meals).uniq) : (@kitchens = kitchens_of_searched_meals)
    
    @kitchens = Kaminari.paginate_array( @kitchens.sort! {|a,b| (!a.is_open).to_s <=> (!b.is_open).to_s} ).page(params[:page]) if @kitchens.present?
    @meals = Kaminari.paginate_array( @meals.sort! {|a,b| (!a.kitchen.is_open).to_s <=> (!b.kitchen.is_open).to_s } ).page(params[:page]) if @meals.present?
     
    @delivery_areas = Area.where(:status => AREA_STATUS_ACTIVE).to_a.uniq{|x| x.area_name}
    #---------------for filters infos-----------------
    @sub_menus, @categories = get_filters_info 
  end
  
  def advance_options_available?
    params[:meal_type].present? || params[:sub_menu_ids].present? || params[:cuisines].present? || params[:spicy_levels].present? 
  end

  def get_advance_options
    advance_options = Hash.new

    if params[:meal_type].present?
       veg_non_veg_category = []
       veg_non_veg_category << true if params[:meal_type].include?(VEG_MEAL)
       veg_non_veg_category << false if params[:meal_type].include?(NON_VEG_MEAL)
       advance_options[:veg_non_veg] = veg_non_veg_category
    end
    if !params[:sub_menu_ids].include?(ALL)
       sub_menu_ids = []
       params[:sub_menu_ids].each { |sub_menu_id| sub_menu_ids << sub_menu_id.to_i }
       advance_options[:sub_menu_ids] =  sub_menu_ids
    end if params[:sub_menu_ids].present?

    if params[:cuisines].present?
       cuisines = []
       params[:cuisines].each { | c | cuisines << c }
       advance_options[:cuisines] = cuisines
    end

    if params[:spicy_levels].present?
       spicy_levels = []
       params[:spicy_levels].each { |sl| spicy_levels << sl }
       advance_options[:spicy_levels] = spicy_levels
    end
    return advance_options
  end

  def get_user_criteria
    return session[:user_input]
  end
  
  def autocomplete_dish_name
    term = params[:term]
    if term && !term.empty?
        items = Meal.select("distinct meal_name as description").where("LOWER(meal_name) like ?", '%' + term.downcase + '%').limit(10).order(:meal_name) + 
                Kitchen.select("distinct kitchen_name as description").where("LOWER(kitchen_name) like ?", '%' + term.downcase + '%').limit(10).order(:kitchen_name) +
                Area.select("distinct area_name as description").where("LOWER(area_name) like ?", '%' + term.downcase + '%').limit(10).order(:area_name) 
     else
       items = {}
     end
     render :json => json_for_autocomplete(items, :description)
  end
  
  def autocomplete_area_name
    term = params[:term]
    if term && !term.empty?
        items = Area.select("distinct area_name as description").where("LOWER(area_name) like ?", '%' + term.downcase + '%').limit(10).order(:area_name)
     else
       items = {}
     end
     render :json => json_for_autocomplete(items, :description)
  end
  
  def autocomplete_city_name
    term = params[:term]
    if term && !term.empty?
        items = City.select("distinct city_name as description").where("LOWER(city_name) like ?", '%' + term.downcase + '%').limit(10).order(:city_name)
     else
       items = {}
     end
     render :json => json_for_autocomplete(items, :description)
  end
  
  def category_advance_search
    user_criteria = get_user_criteria
    meals = Meal.text_search(nil, user_criteria, nil)
    
    @meals = []
    if params[:selected_type].casecmp('category') == 0
     meals.each { |m| @meals << m if m.meal_present_and_active_in_category?( params[:selected_type_id] )  } if params[:selected_type_id] != ALL 
    else
     meals.each { |m| @meals << m if m.sub_menu_id == params[:selected_type_id].to_i } if params[:selected_type_id] != ALL
    end
    @meals = meals if params[:selected_type_id] == ALL
    
    @meals = Kaminari.paginate_array( @meals.sort! {|a,b| (!a.kitchen.is_open).to_s <=> (!b.kitchen.is_open).to_s } ).page(params[:page]) if @meals.present?
    @delivery_areas = Area.where(:status => AREA_STATUS_ACTIVE).to_a.uniq{|x| x.area_name}
    
    if params[:page].present?
      @sub_menus, @categories = get_filters_info
      return  render 'index'
    end
    render :partial => 'meal_results_with_pagination', :locals => {:meals => @meals, :delivery_areas => @delivery_areas}
  end  
  
  
end
