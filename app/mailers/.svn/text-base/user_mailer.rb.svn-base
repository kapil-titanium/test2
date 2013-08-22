class UserMailer < ActionMailer::Base
  
  default :from => "#{SUPPORT_EMAIL}"  
  def marketing_email_id_for_bcc
      if Rails.env.production?
        return MARKETING_EMAIL
      elsif Rails.env.test?
        return TESTER_EMAILS
      elsif Rails.env.development?
        return DEVELOPER_EMAILS
      end
  end
  
  def operation_email_id_for_bcc
      if Rails.env.production?
        return OPERATIONS_EMAIL
      elsif Rails.env.test?
        return TESTER_EMAILS
      elsif Rails.env.development?
        return DEVELOPER_EMAILS
      end
  end
  
  def user_registration_confirmation(login)
      @lgn = login
      mail(:to => login.user.primary_email_id,  :subject => "RasoiClub Registration")
  end
  
  def kitchen_registration_confirmation(kitchen)
      @kitchen = kitchen
      mail(:to => kitchen.primary_email_id, :bcc => marketing_email_id_for_bcc, :subject => "RasoiClub Kitchen Registration") if !kitchen.primary_email_id.blank?
    
  end
  
  def registration_password_confirmation(login)
      @lgn = login
      mail(:to => login.user.primary_email_id, :subject => "RasoiClub Registration - Password")
  end
  
  def reset_password(login)
      @lgn = login
      mail(:to => @lgn.user_name, :subject => "Successful RasoiClub Password Reset.")
  end
  
  def forgot_password(login)
    @lgn = login
    mail(:to =>  @lgn.user_name, :subject => "Successful RasoiClub Password Reset")
  end
  
  def forgot_username(user)
    @user = user
    mail(:to =>  @user.alternate_email_id, :subject => "RasoiClub - Account Details")
  end
  
  def kitchen_approval(kitchen)
    @kitchen = kitchen
    mail(:to => kitchen.primary_email_id, :bcc => marketing_email_id_for_bcc, :subject => "RasoiClub Kitchen Approved", :from => "#{SUPPORT_EMAIL}") if !kitchen.primary_email_id.blank?
  end
  
  def kitchen_rejection(kitchen)
    @kitchen = kitchen
    mail(:to => kitchen.primary_email_id, :bcc => marketing_email_id_for_bcc, :subject => "RasoiClub Kitchen Rejected", :from => "#{SUPPORT_EMAIL}") if !kitchen.primary_email_id.blank?
  end
  
  def kitchen_activation(kitchen)
    @kitchen = kitchen
    mail(:to => kitchen.primary_email_id, :bcc => operation_email_id_for_bcc, :subject => "RasoiClub Kitchen Activated", :from => "#{SUPPORT_EMAIL}") if !kitchen.primary_email_id.blank?
  end
  
  def kitchen_suspend(kitchen)
    @kitchen = kitchen
    mail(:to => kitchen.primary_email_id, :bcc => operation_email_id_for_bcc, :subject => "RasoiClub Kitchen Suspended", :from => "#{SUPPORT_EMAIL}") if !kitchen.primary_email_id.blank?
  end
  
  def order_confirmation_to_consumer(order)
    @order = order
    @user = order.user
    #@line_items = order.line_items
    @line_items = order.get_line_items
    
    mail(:to => @user.primary_email_id, :bcc => operation_email_id_for_bcc, :subject => "Order Confirmation", :from => "#{SUPPORT_EMAIL}") if !@user.primary_email_id.blank?
  end
  
  def order_confirmation_to_kitchen(kitchen, order)
    @kitchen = kitchen
    #@order = order
    @order = order.child_orders.find_by_kitchen_id(kitchen.id)
    #@line_items = kitchen.line_items.where(:order_id => order.id)
    @line_items = @order.line_items
    
    mail(:to => @kitchen.primary_email_id, :bcc => operation_email_id_for_bcc, :subject => "Order Confirmation", :from => "#{SUPPORT_EMAIL}") if !@kitchen.primary_email_id.blank?
  end
end
