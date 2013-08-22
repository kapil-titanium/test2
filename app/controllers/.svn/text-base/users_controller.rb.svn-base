
class UsersController < ApplicationController
  load_and_authorize_resource

  def index
      @users = User.order('id asc').all
  end
  
  def show
      @user = User.find(params[:id])
  end
  
  def new
      # lgn = Login.new
      # @user = lgn.build_user
      @user = User.new
      respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
  def create
      @user = User.new(params[:user])
      if @user
         @user.login = Login.create_login(@user.primary_email_id, generate_password)
         respond_to do |format|
           if @user.save #@user.login.save && 
              UserMailer.user_registration_confirmation(@user.login).deliver
              UserMailer.registration_password_confirmation(@user.login).deliver
              flash[:notice] = "You are registered Successfully. Your login details are sent to your registered mail id."
    
              format.html { redirect_to new_login_path}
              format.json { render json: @user, status: :created, location: @user }
              # format.html { redirect_to session.delete(:return_to)}
              # format.json { render json: @user, status: :created, location: @user }
           else
              format.html { render action: "new" }
              format.json { render json: @user.errors, status: :unprocessable_entity }
           end
         end
      else
         render('new')
      end
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
      @user = User.find(params[:id])
      # @lgn = @user.login
      respond_to do |format|
        if @user.update_attributes(params[:user])
          # gup = Gupshup::Enterprise.new(:userid => '2000104389', :password => 'TheEdge!23')
          # gup.send_text_message(:msg => ' Plan: "Plan Name" ; Start: "15-09-2012"; End: "15-09-2012" has been confirmed.', :send_to => '919923715557')
          # UserMailer.updation_confirmation(@user.primary_email_id, current_user).deliver
          
          flash[:notice] = "Your details have been updated"
          format.html { redirect_to user_path(@user) }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
  
  def my_orders
    @user = User.find(params[:user_id])
    @orders = @user.orders.order('delivery_date desc').open_user_orders
  end
  
  def get_current_orders
    @user = User.find(params[:user_id])
    @orders = @user.orders.order('delivery_date desc').open_user_orders
    render :partial => 'orders/orders_list', :locals => {:orders => @orders }
  end
  
  def get_orders_history
    @user = User.find(params[:user_id])
    @orders = @user.orders.order('delivery_date desc').user_order_histroy
    render :partial => 'orders/orders_list', :locals => {:orders => @orders }
  end
  
end
