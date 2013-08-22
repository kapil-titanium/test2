class MealsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @kitchen = Kitchen.find(params[:kitchen_id])
    @meals = @kitchen.meals
    @categories = Category.all
  end

  def new
    @kitchen = Kitchen.find(params[:kitchen_id])
    @meal = @kitchen.meals.build if @kitchen.present?
    @picture = Picture.new
    @meal.build_week
    @menus = Menu.all
  end

  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @meal = @kitchen.meals.build(params[:meal]) if @kitchen.present?
    @meal.sub_menu_id = params[:sub_menu_id]
    if params[:dishes].present? && @meal.save
      @meal.build_week(params[:week])
      @meal.save
      params[:dishes].each {|dish_id| @meal.meal_dishes.build(:dish_id => dish_id).save } if params[:dishes].present?
      @meal.add_meal_to_default_meal_category
      redirect_to kitchen_meals_path(@kitchen)
    else
      redirect_to :back 
    end
  end

  def edit
      @kitchen = Kitchen.find(params[:kitchen_id])
      @meal = Meal.find(params[:id])
      @menus = Menu.all
      @courses =  @meal.sub_menu.courses
      @sub_menu_courses_infos = @meal.sub_menu.sub_menu_course_infos
      @dishes = @kitchen.dishes if @kitchen.present?
      @picture = Picture.new
      @picture = @meal.picture if @meal.picture.present?
  end

  def update
      @kitchen = Kitchen.find(params[:kitchen_id])
      @meal = @kitchen.meals.find(params[:id]) if @kitchen.present?
      p_attr = params[:meal][:picture_attributes]
      @meal.update_or_duplicate_item(params[:meal], params[:sub_menu_id].to_i, params[:dishes], params[:week])
      @meal.inactivate_all_meal_categories_except_standard if !@meal.is_meal_active?
      @meal.change_default_meal_category_status
      # @meal.sub_menu_id = params[:sub_menu_id]
      # if @meal.update_attributes(params[:meal])
        # params[:dishes].each {|dish_id| @meal.meal_dishes.build(:dish_id => dish_id).save } if params[:dishes].present?
      redirect_to kitchen_meals_path(@kitchen)
      # else
        # redirect_to :back 
      # end
  end
  
  def get_sub_menus
    @sub_menus  = SubMenu.where( :menu_id => params[:menu_id] )
    render :partial => 'sub_menu_partial', :locals => {:sub_menus => @sub_menus }
  end

  def get_dishes_for_meal_creation
    @sub_menu = SubMenu.find(params[:sub_menu_id])
    @kitchen = Kitchen.find(params[:kitchen_id])
    @sub_menu_courses_infos = @sub_menu.sub_menu_course_infos
    @courses =  @sub_menu.courses
    @dishes =  @kitchen.dishes  if @kitchen.present?
    render :partial => 'kitchen_dishes', :locals => {:sub_menus => @sub_menus, :courses => @courses, :dishes => @dishes, :sub_menu => @sub_menu }
  end
  
  def add_meal_to_categories
    @meal = Meal.find(params[:meal_id])
    @meal.inactivate_all_meal_categories_except_standard
    meal_categories_id = @meal.categories.map(&:id)
    
    params[:category_id_arr].split(',').each do |id|
      if meal_categories_id.include?(id.to_i)
        MealCategory.where(:meal_id => params[:meal_id]).find_by_category_id(id).update_attributes(:status => MEAL_STATUS_ACTIVE)
      else  
        @meal.categories << Category.find(id)
        MealCategory.where(:meal_id => params[:meal_id]).find_by_category_id(id).update_attributes(:status => MEAL_STATUS_ACTIVE)
      end
    end if (params[:category_id_arr].present? && params[:category_id_arr] != 'null')
    
    @meal = Meal.find(params[:meal_id])
    @meal.calculate_total_cost_for_meal
    @categories = Category.all   
    render :partial => 'meal_categories', :locals => {:meal => @meal, :categories => @categories}
  end
  
  def get_meal_detail_info
    @meal = Meal.find(params[:meal_id])
    render :partial => '/searches/meal_details', :locals => {:meal => @meal }
  end
end
