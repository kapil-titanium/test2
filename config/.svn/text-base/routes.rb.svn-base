RasoiclubCom::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  
  root :to => 'homes#index'
  
  # ------------------------Application Routes---------------------------- #
  get "/application/save_user_criteria_form" => "application#save_user_criteria_form" 
  post "/application/save_user_criteria_form" => "application#save_user_criteria_form"
  
  # ------------------------Meal Routes---------------------------- #
  get  "/meals/get_sub_menus/:menu_id" => "meals#get_sub_menus", :constraints => { :menu_id => /.*/} 
  post "/meals/get_sub_menus/:menu_id" => "meals#get_sub_menus", :constraints => { :menu_id => /.*/}
  
  get  "/meals/get_dishes_for_meal_creation/:sub_menu_id/:kitchen_id" => "meals#get_dishes_for_meal_creation"
  post "/meals/get_dishes_for_meal_creation/:sub_menu_id/:kitchen_id" => "meals#get_dishes_for_meal_creation"
  
  get  "/meals/get_sub_menu" => "meals#get_sub_menu"
  get  "/meals/add_meal_to_categories/:meal_id/:category_id_arr" => "meals#add_meal_to_categories" 
  get  "/meals/get_meal_detail_info/:meal_id" => "meals#get_meal_detail_info"
  
  
  # ------------------------Gallery Routes----------------------------#
  put "/galleries/add_pictures/:kitchen_id" => "galleries#add_pictures"
  
  # ------------------------Dish Routes---------------------------- #
  get "/dishes/get_dish_for_edit/:dish_id" => "dishes#get_dish_for_edit" 
  
  # ------------------------Search Routes---------------------------- #
  post "/searches" => "searches#index"
  get  "/searches/category_advance_search/:selected_type_id/:selected_type" => "searches#category_advance_search" 
  # ------------------------Basket Routes---------------------------- #
  get "/baskets/view" => "baskets#view"
  post "/baskets/view" => "baskets#view"
  get "/baskets/add_to_basket/:item_id/:qty" => "baskets#add_to_basket"
  post "/baskets/add_to_basket/:item_id/:qty" => "baskets#add_to_basket"
  
  get "/baskets/add_to_basket_on_submit_input/:item_id/:qty" => "baskets#add_to_basket_on_submit_input" 
  post "/baskets/add_to_basket_on_submit_input/:item_id/:qty" => "baskets#add_to_basket_on_submit_input"
  
  post "/baskets/proceed_to_check_out" => "baskets#proceed_to_check_out"
  
  get  "/baskets/before_order_conform_validations" => "baskets#before_order_conform_validations"
  post "/baskets/before_order_conform_validations" => "baskets#before_order_conform_validations"
  
  post "/baskets/remove_basket_item/:line_item_id" => "baskets#remove_basket_item"
  post "/baskets/change_quantity/:line_item_id/:quantity" => "baskets#change_quantity"
  
  # ------------------------Login Routes---------------------------- #
  get 'logins/forgot_password' => 'logins#forgot_password'
  post 'logins/send_temporary_password' => 'logins#send_temporary_password'
  
  get 'logins/forgot_username' => 'logins#forgot_username'
  post 'logins/send_username' => 'logins#send_username'
  
  # ------------------------Orders Routes----------------------------
  get "/orders/open_parents" => "orders#open_parents"
  get "/orders/children" => "orders#children"
  post "/orders/settle_payment" => "orders#settle_payment"
  get "/orders/get_all_orders" => "orders#get_all_orders"
  get "/orders/closed_in_payments" => "orders#closed_in_payments"
  get "/orders/closed_out_payments" => "orders#closed_out_payments"
  get "/orders/cancel" => "orders#cancel"
  
  # ------------------------Kitchens Routes----------------------------
  get '/kitchens/kitchen_open_close/:kitchen_id' => 'kitchens#kitchen_open_close'
  
  get "/kitchens/get_kitchens" => "kitchens#get_kitchens"
  get "/kitchens/new_registrations" => "kitchens#new_registrations"
  get "/kitchens/unapproved" => "kitchens#unapproved"
  get "/kitchens/approved" => "kitchens#approved"
  get "/kitchens/rejected" => "kitchens#rejected"
  get "/kitchens/activated" => "kitchens#activated"
  get "/kitchens/suspend" => "kitchens#suspend"
  get "/kitchens/to_be_activated" => "kitchens#to_be_activated"
  post "/kitchens/change_status" => "kitchens#change_status"  
  
  # ------------------------User Routes----------------------------
   
  # ------------------------Resources - Routes---------------------------- 
  
  # ------------------------Homes Resources - Routes---------------------------- 
  resources :homes
  
  # ------------------------Logins Resources - Routes---------------------------- 
  resources :logins do
    get 'reset_password'
    put 'save_changed_password'
  end
  
  # ------------------------Users Resources - Routes---------------------------- 
  resources :users do
    get "my_orders"
    get 'get_current_orders'
    get 'get_orders_history'
    resources :addresses
  end

  # ------------------------Kitchens Resources - Routes----------------------------  
  resources :kitchens do
    resources :galleries do
      post 'make_default'     
      resources :pictures do
        collection do
          post 'make_default'
        end
      end
    end
    get 'profile_setting'
    put 'save_profile_setting'
    get 'get_current_orders'
    get 'get_orders_history'
    resources :dishes
    resources :meals
  end

  # ------------------------Searchs Resources - Routes----------------------------  
  resources :searches do
    get :autocomplete_dish_name, :on => :collection
    get :autocomplete_city_name, :on => :collection
    get :autocomplete_area_name, :on => :collection
  end
  
  # ------------------------Orders Resources - Routes----------------------------
  resources :orders do
    get 'bill_info'
  end
  
  # ------------------------Employees Resources - Routes----------------------------
  resources :employees
  

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
