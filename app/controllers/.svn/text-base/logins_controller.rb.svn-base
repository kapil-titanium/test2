
class LoginsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @login = Login.new
    session[:login_id] = nil
    session[:return_to] ||= request.referer
  end
  
  def create
    lgn = Login.find_by_user_name(params[:login][:user_name])
    if lgn
      flash[:notice] = check_user(lgn)
      if flash[:notice].blank?
        if lgn.authenticate(params[:login][:password])
          lgn.attempts = 0
          session[:login_id] = lgn.id
          basket = Basket.find(session[:basket_id]) if session[:basket_id].present? # Note: Don't use "get_current_basket" method here
          basket.user_id = current_user.id if basket.present? 
          basket.save if basket.present?
          
          if lgn.first_time_login == 0
              lgn.update_attribute(:first_time_login , 1)
              redirect_to login_reset_password_path(lgn) and return
              # redirect_to( :action => 'reset_password', :id => lgn.id, :controller => 'logins')
          else
            if current_user.is_user?
                redirect_to session.delete(:return_to) and return
            elsif current_user.is_kitchen?
                session.delete(:return_to)
                redirect_to kitchen_path(current_user.kitchen) and return
            elsif current_user.is_employee?
                session.delete(:return_to)
                redirect_to employee_path(current_user.employee) and return
            end
          end
          
        else          
          lgn.attempts += 1          
          lgn.attempts = 1 if lgn.login_date != DateTime.now.to_date          
          flash[:notice] = "Invalid password.Try again."
          flash[:notice] = "Your account has been locked. Please contact helpdesk (#{SUPPORT_EMAIL})."  if lgn.attempts >= 3
        end
        lgn.update_attributes(:attempts => lgn.attempts, :login_date => DateTime.now.to_date, :first_time_login => lgn.first_time_login)
      end
      @login = Login.new
      render('new')
    else
      flash[:notice] = "User name doesn't exist .Please contact helpdesk (#{SUPPORT_EMAIL})."
      @login = Login.new
      render('new')
    end
  end
  
  def check_user(lgn)
     return "Your account has been locked. Please contact customer care." if lgn.attempts >= 3
     return "Your account is Inactive. Please contact customer care." if !(lgn.user.nil?) && lgn.user.status && lgn.user.status.downcase == 'inactive'
     # return "Your account is Inactive. Please contact customer care." if !(lgn.kitchen.nil?) && lgn.kitchen.status && lgn.kitchen.status.downcase == 'inactive'
  end
  
  def reset_password
    flash[:notice] = ''
    @login = Login.find(params[:login_id])
    # authorize! :reset_password, @login
  end
  
  def save_changed_password
    if params[:commit] == 'Cancel'
      @login = Login.find(params[:login][:id])
      k_id = @login.user.kitchen if @login.user.kitchen.present?
      redirect_to(:controller => 'kitchens', :action => 'show', :id => k_id) and return if !k_id.nil? 
      redirect_to(:controller => 'homes', :action => 'index') and return      
    else
       lgn = Login.find_by_user_name(params[:login][:user_name])
       if lgn && lgn.authenticate(params[:login][:old_password]) && (params[:login][:old_password] != params[:login][:password])
          lgn.password = params[:login][:password]
          lgn.password_confirmation = params[:login][:password_confirmation]
          if lgn.password.present? && lgn.password_confirmation && lgn.save
             UserMailer.reset_password(lgn).deliver
             flash[:notice] = "Your password has been successfully changed."
             if current_user.is_user?
                redirect_to :root and return #(:controller => 'searches', :action => 'index')
             elsif current_user.is_kitchen?
                redirect_to kitchen_path(current_user.kitchen) and return
             elsif current_user.is_employee?
                redirect_to employee_path(current_user.employee) and return
             end
          else
            @login = lgn
             # @login = Login.new(params[:login])
             flash[:notice] = "Supplied passwords not in correct format."
             flash[:notice] = "Please enter Confirmation Password." if !lgn.password_confirmation.present?
             flash[:notice] = "Please enter new password." if !lgn.password.present?
             flash[:notice] = "Supplied passwords doesn't match." if lgn.password_confirmation.present? && lgn.password != lgn.password_confirmation
             render 'reset_password' 
          end
       else
          @login = lgn
          # @login = Login.new(params[:login])
          flash[:notice] = 'Incorrect existing password.'
          flash[:notice] = 'Old Password and New Password should be different.' if params[:login][:old_password] == params[:login][:password]
          flash[:notice] = 'Please enter old password.' if !params[:login][:old_password].present?
          render 'reset_password'
       end
    end
  end
  
  def forgot_password
    flash[:notice] = ''
    @login = Login.new
  end
  
  def send_temporary_password
    if params[:commit] == 'Generate'
      lgn = Login.find_by_user_name(params[:login][:user_name])
      if lgn
          lgn.password_confirmation = lgn.password = generate_password
          lgn.first_time_login = 0
          lgn.attempts = 0
          if lgn.save
            UserMailer.forgot_password(lgn).deliver
            flash[:notice] = "Temporary password has been sent to your email."
            redirect_to :action => 'new' 
          end             
      else
        @login = Login.new(:user_name => params[:login][:user_name])
        flash[:notice] = "Invalid Email ID"
        render :action => 'forgot_password'
      end  
    elsif params[:commit] == "Cancel"
      flash[:notice] = ''
      redirect_to :action => 'new'
    end
  end
  
  def forgot_username
      flash[:notice] = ''
  end
  
  def send_username
    if params[:commit] == "Send"
      
      if !params[:alternate_email_id].blank?
         users = User.find_all_by_alternate_email_id(params[:alternate_email_id])
         if users.present?
            users.each do |user|
              UserMailer.forgot_username(user).deliver
            end
            flash[:notice] = "Email with username details are sent on the alternate email id"
            redirect_to :action => 'new' 
         else
            flash[:notice] = "Username recover process failed."
            render :action => 'forgot_username'
         end
         
      elsif !params[:primary_mobile_number].blank?
         users = User.find_all_by_primary_mobile_number(params[:primary_mobile_number])
         if users.present?
            # users.each do |user|
              # UserMailer.forgot_username(user).deliver
            # end
            #TODO: Code here for sms
            flash[:notice] = "Username details are sent via sms on the registered mobile number"
            redirect_to :action => 'new' 
         else
            flash[:notice] = "Username recover process failed"
            redirect_to :action => 'forgot_username'
         end         
         
      else
        flash[:notice] = "Either alternate Email Id OR Mobile number is required"
        redirect_to :action => 'forgot_username'
      end
    elsif params[:commit] == "Cancel"
      flash[:notice] = ''
      redirect_to :action => 'new'
    end
  end
  
  def destroy
    session[:login_id] = nil
    flash[:notice] = ''
    @current_user = nil
    @current_login = nil
    redirect_to root_url
  end
  
end
