
class OrdersController < ApplicationController
  load_and_authorize_resource
  
  def index
      @employee = Employee.find(current_user.employee) if current_user.employee.present?
      @orders = Order.order('id desc').all
  end
  
  def bill_info
      @order = Order.find(params[:order_id])
  end
  
  def show
      @order = Order.find(params[:id])
      @order.update_attributes(:status => ORDER_STATUS_OPEN) if !@order.parent? && current_user.is_kitchen? && @order.kitchen_id == current_user.kitchen.id && @order.status == ORDER_STATUS_NEW
  end
  
  #-----------------------------Orders: Access to employee only------------------
  
  def get_all_orders
      @orders = Order.order('id desc').all
      render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  def open_parents
    @orders = Order.open_parents.order('id desc')
    render :partial => '/orders/orders_change_status', :locals => {:orders => @orders }
  end
  
  def children
    @orders = Order.open_children.order('status asc, id desc')
    render :partial => '/orders/orders_change_status', :locals => {:orders => @orders }
  end
  
  def closed_in_payments
      @orders = Order.settled_parents
      render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  def closed_out_payments
      @orders = Order.settled_children
      render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  def cancel
    @orders = Order.cancelled
    render :partial => '/orders/orders_list', :locals => {:orders => @orders }
  end
  
  def settle_payment
    amt = params[:amount]
    order = Order.find_by_id(params[:id])
    order.remark = params[:remark]
    if params[:commit] == 'Settle'
       if order.parent?
          order.payment = Payment.new(:amount => amt, :method => PAYMENT_METHOD_COD, :order_id => order.id)
       else
         order.out_payment = OutPayment.new(:amount => amt, :approver_id => current_user.id, :creator_id => current_user.id, :method => PAYMENT_METHOD_COD, :order_id => order.id, :status => :closed)
       end
       # order.amount == amt.to_f ? order.status = ORDER_STATUS_SETTLED :  order.status = ORDER_STATUS_PARTIALLY_SETTLED
       if order.grand_total == amt.to_f
          order.status = ORDER_STATUS_SETTLED
       elsif order.grand_total > amt.to_f
          order.status = ORDER_STATUS_PARTIALLY_SETTLED
       end      
    elsif params[:commit] == 'Cancel'      
      change_status order, ORDER_STATUS_CANCELED
    elsif params[:commit] == 'Close'
       change_status order, ORDER_STATUS_CLOSED 
    end
    order.save
    redirect_to order_path(order) 
  end
  
  def change_status(order, status)
    order.status = status
    if order.parent?
      order.child_orders.each do |o|
        o.status = status
        o.remark = order.remark
        o.save  
      end
    end
  end
  
end
