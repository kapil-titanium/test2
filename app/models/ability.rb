class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    # ------------------------General Access (When no user is logged in)----------------------------
    # can [:read, :index], [Home]
    can [:show], [Kitchen, Gallery]
    can [:index], [Gallery]
    can [:new, :create, :destroy], [Login]
    can [:get_meal_detail_info], [Meal]
    if user.id.nil?
       can [:new, :create], [Kitchen, User]
       can [:forgot_password, :send_temporary_password, :forgot_username, :send_username], [Login]
    else
      can [:reset_password, :save_changed_password], Login do |login|
        login.user.id == user.id if user
      end
    end
    can [:view, :add_to_basket, :add_to_basket_on_submit_input, :destroy_basket, :before_order_conform_validations, :change_quantity, :remove_basket_item], Basket
    # ------------------------User Access----------------------------
    if user.is_user?
      can [:new, :create], Address
      can [:index, :edit, :update, :destroy], Address do |address|
         address.user_id == user.id if user
      end
      
      can [:show, :edit, :update, :my_orders, :get_current_orders, :get_orders_history], User do |u|
        u.id == user.id if user
      end
      
      can [:get_meal_detail_info], [Meal]
      can [:proceed_to_check_out, :proceed_to_payment, :payment_gateway, :create_order, :add_kitchen_order, :add_to_ledger], Basket
      
      can [:show, :bill_info], Order do |order|
         order.user_id == user.id if user && order.user_id
       end
      
    # ------------------------Kitchen Access----------------------------
    elsif user.is_kitchen?
      
      cannot [:view], Basket
      
      can [:edit, :update, :kitchen_open_close, :profile_setting, :save_profile_setting, :get_orders_history, :get_current_orders], Kitchen do |k|
        k.user.id == user.id if user
      end
      
      can [:new, :create], [Gallery, Picture, Dish, Meal]
      
      can [:edit, :update, :destroy, :add_pictures], Gallery  do |g|
        g.kitchen.user_id == user.id if user
      end
      
      can [:edit, :update, :destroy], Picture do |p|
        p.gallery.kitchen.user_id == user.id if user
      end
      
      can [:index, :show, :edit, :update, :delete, :get_dish_for_edit], Dish do |d|
        d.kitchen.user_id == user.id if user
      end
      
      can [:index, :edit, :update, :get_sub_menus, :get_dishes_for_meal_creation, :add_meal_to_categories, :get_meal_detail_info], Meal do |m|
        m.kitchen.user_id == user.id if user
      end
      
      can [:show], Order do |order|
        order.kitchen.user_id == user.id if user && order.kitchen.present?
      end
      
    
    # ------------------------Employee Access----------------------------
    elsif user.is_employee?
      can :manage, [User, Kitchen, Gallery, Picture, Meal, Dish, Address, Order]
    end
    
  end
end
