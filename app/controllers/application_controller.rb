class ApplicationController < ActionController::Base
  include BasketsHelper
  include ApplicationHelper
  protect_from_forgery
  
  # -----------------------------------Rescue from authorization------------------------------
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
  end
  
  # ----------------------------------- ------------------------------
  before_filter :set_cache_buster
  after_filter :flash_to_headers
  
  helper_method :current_login
  helper_method :current_user
  helper_method :generate_password
  helper_method :get_current_basket
  helper_method :save_user_criteria_form
  helper_method :get_filters_info
  
  # -----------------------------------To Prevent Unauthenticated Access------------------------------
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  # -----------------------------------Helper Methods------------------------------
  public
  def flash_to_headers
    return unless request.xhr?
    flash_json = Hash[flash.map{|k,v| [k,ERB::Util.h(v)] }].to_json
    response.headers['X-Flash-Messages'] = flash_json

    flash.discard
  end
  
  def generate_password
    ((('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle[0..8] + (0..100).to_a.shuffle[1..1]).shuffle.join
  end
  
  def current_login    
    @current_login ||= Login.find_by_id(session[:login_id]) if session[:login_id] && !session[:login_id].blank?
  end

  def current_user
    @current_user ||= current_login.user if current_login.present?    
  end
  
  def get_current_basket
    if session[:basket_id].present?
      return Basket.where('id = ?', session[:basket_id]).first
    else
      basket = Basket.create(:user_id => current_user.present? ? current_user.id : nil)
      session[:basket_id] = basket.id
      return basket 
    end
  end
  
  def save_user_criteria_form
    save_user_criteria(nil, params[:menu], params[:delivery_date], params[:area_id_by_area], params[:delivery_time].present? ? params[:delivery_time] : nil)   #TODO: pass city when comes from popup
    if session[:item_to_be_added_in_basket].present?
      redirect_to "/baskets/add_to_basket_on_submit_input/" + session[:item_to_be_added_in_basket][:meal_category_id].to_s + "/" + session[:item_to_be_added_in_basket][:qty].to_s
    else
      validate_existing_basket_items
      redirect_to "/searches"
    end
         
  end
  

  def save_user_criteria(city, menu, delivery_date, area_id, delivery_time)
    get_user_input_session
    
    session[:user_input][:menu] = menu if menu.present?
    session[:user_input][:delivery_date] = delivery_date if delivery_date.present?
    session[:user_input][:area_id] = area_id if area_id.present? 
    session[:user_input][:city] = city if city.present?
    session[:user_input][:delivery_time] = (session[:user_input][:menu].casecmp(MENU_NAME_DINNER) == 0) ? nil : (delivery_time.present? ? delivery_time : session[:user_input][:delivery_time]) if session[:user_input][:menu].present?
  end
  
  
  def get_filters_info
  	menu = Menu.find_by_menu_name(session[:user_input][:menu]) if (session[:user_input].present? && session[:user_input][:menu].present?)
    @sub_menus = menu.sub_menus if menu.present?
    @categories = menu.categories if menu.present?
    return @sub_menus,  @categories
  end
  
  
  def user_criteria_present?
    user_input = get_user_input_session
    user_input.each do |k, v|
      if !v.present? && k != :delivery_time && user_input[:menu] == MENU_NAME_DINNER
        return false  
      elsif !v.present? && user_input[:menu] == MENU_NAME_PARTY
        return false
      end  
    end
    return true      #TODO: code should be reviewed     
  end
  
  
  def delete_item_from_session
    session.delete(:item_to_be_added_in_basket) if session[:item_to_be_added_in_basket].present?
  end

end
