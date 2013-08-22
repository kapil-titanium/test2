
class BasketsController < ApplicationController
  include BasketsHelper
  load_and_authorize_resource
  
  def add_to_basket
    meal_category_id = params[:item_id].to_i
    qty = params[:qty].to_i
    
    if !user_criteria_present?
      session[:item_to_be_added_in_basket] = {:meal_category_id => meal_category_id, :qty => qty}
      
      respond_to do |format|
        format.json { head :no_content }
      end
      return
    end
    
    result, message = validate_and_add_line_item( meal_category_id, qty )
    
    render :partial => "update_basket", :locals => { :result => result, :message => message }      #, :basket_id => session[:basket_id]}  #TODO: what's d use of :basket_id
    return
  end
  
  def add_to_basket_on_submit_input
    result = nil
    message = nil
    if session[:item_to_be_added_in_basket].present?
      meal_category_id = session[:item_to_be_added_in_basket][:meal_category_id]
      qty = session[:item_to_be_added_in_basket][:qty]
      
      result, message = validate_and_add_line_item( meal_category_id, qty )    
    end
    redirect_to :action => 'index',:controller => 'searches', :result => result, :message => message 
  end 
  
  def view
      @basket = get_current_basket
      @basket_items = @basket.line_items
      if current_user.present?
         area = Area.find(session[:user_input][:area_id]) if session[:user_input].present? && session[:user_input][:area_id].present?
         city = City.find(session[:user_input][:city]) if session[:user_input].present? && session[:user_input][:city].present?
         @addresses = current_user.addresses.where(:area => area.area_name.downcase, :pincode => area.pincode, :city => city.city_name.downcase) if current_user.addresses.present?
         
         @address = Address.new(:country => city.country.capitalize, :area => area.area_name.capitalize, :pincode => area.pincode, :city => city.city_name.capitalize, :state => city.state.capitalize)
         @address.user = User.find_by_id(current_user.id) if !current_user.nil?
      end
  end
  
  def proceed_to_check_out
      if !params[:terms_and_conditions]
          flash[:terms_and_conditions_errors]="T&C must be accepted."
          redirect_to :back
      else
        @basket = get_current_basket
        if params[:shipping_address] == 'on' || params[:billing_address] == 'on'
           @address = Address.new(params[:address])
           if @address.save
              @basket.update_attributes(:shipping_address_id => @address.id) if (params[:shipping_address] == 'on')
              @basket.update_attributes(:billing_address_id => @address.id) if (params[:billing_address] == 'on')
           else
              area = Area.find(session[:user_input][:area_id]) if session[:user_input].present? && session[:user_input][:area_id].present?
              city = City.find(session[:user_input][:city]) if session[:user_input].present? && session[:user_input][:city].present?
              @addresses = current_user.addresses.where(:area => area.area_name.downcase, :pincode => area.pincode, :city => city.city_name.downcase) if current_user.addresses.present?
              render action: "view" and return
           end
        end
        @basket.update_attributes(:shipping_address_id => params[:shipping_address]) if (params[:shipping_address] != 'on')
        @basket.update_attributes(:billing_address_id => params[:billing_address]) if (params[:billing_address] != 'on')
        proceed_to_payment
      end
  end
  
  def proceed_to_payment
      if payment_gateway
        create_order
      end
  end
  
  def payment_gateway
      true
  end
  
  def create_order
    basket = get_current_basket
    user_input = get_user_input_session  
    @order = Order.new(:user_id => basket.user_id, :delivery_date => user_input[:delivery_date], :special_instructions => basket.special_instruction,
                       :billing_address_id => basket.billing_address_id, :shipping_address_id => basket.shipping_address_id, 
                       :delivery_time => user_input[:delivery_time], :sub_total => basket.sub_total, :total_tax => basket.total_tax,
                       :delivery_charge => basket.delivery_charge, :grand_total => basket.grand_total, :terms_and_conditions => true,
                       :status => ORDER_STATUS_NEW) 
    @order.line_items = basket.line_items
    @order.line_items.collect {|i| i.basket_id = nil}
    if @order.save
 
       @order.update_attribute(:order_number, @order.generate_order_number( @order.shipping_address.city ) )          
       destroy_basket( basket.id )
       add_kitchen_order( @order )    
       add_to_ledger( @order )        
       
       kitchens = @order.kitchens
       kitchens.each do |kitchen|
         child_order = Order.new()
         child_order.build_child_order(@order, kitchen)   
         child_order.save
        UserMailer.order_confirmation_to_kitchen(kitchen, @order).deliver
       end
        UserMailer.order_confirmation_to_consumer(@order).deliver
       redirect_to order_bill_info_path( @order )
    else
    	render action: 'view'
    end
  end
  
  def destroy_basket( basket_id )
     current_basket = Basket.find(basket_id)
     current_basket.destroy
     session.delete(:basket_id)
  end 
  
  def add_kitchen_order( order )
      order.line_items.each { |li|
      kitchen = li.meal_category.meal.kitchen
      kitchen_order = KitchenOrder.where(:kitchen_id => kitchen.id, :order_id => order.id).first
      if !kitchen_order.present?
        kitchen_order = KitchenOrder.create(:kitchen_id => kitchen.id, :order_id => order.id)
      end
      kitchen_order_li = KitchenOrderLineItem.create(:kitchen_order_id => kitchen_order.id, :line_item_id => li.id )
    }
  end 
  
  def add_to_ledger(order)
      order.line_items.each do |li|
        meal_category = li.meal_category
        meal = meal_category.meal
        Ledger.create(:order_number => order.order_number, :meal_category_id => meal_category.id, :sold_qty => li.quantity,
                      :total_price => li.total_price, :sold_date => order.delivery_date,
                      :kitchen_id => meal.kitchen_id, :menu_id => meal.sub_menu.menu_id )
      end
  end
  
  def before_order_conform_validations
    # validation call
    @error_hash = validate_existing_basket_items
    if !get_current_basket.line_items.all? {|li| li.is_valid? == true }
        render :partial => 'basket_line_items', :locals => {:error_hash => @error_hash} 
    else
      format.json { head :no_content }  
    end 
    # end of validation call
  end
  
  def change_quantity
    basket = get_current_basket
    @baskets_item = basket.line_items.find(params[:line_item_id])
    
    @baskets_item.quantity = params[:quantity].nil? ? 1 : params[:quantity]
    @baskets_item.update_line_item
    @baskets_item.save
    update_basket(get_current_basket)
    render :partial => "basket_contents", :locals => { :result => true, :message => "Quantity has been changed" }
  end
  
   def remove_basket_item
    basket = get_current_basket
    @baskets_item = basket.line_items.find(params[:line_item_id])
    @baskets_item.destroy
    update_basket(get_current_basket)
    render :partial => "basket_contents", :locals => { :result => true, :message => "Removed successfully" }
  end
  
end
