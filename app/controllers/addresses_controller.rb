
class AddressesController < ApplicationController
  load_and_authorize_resource
  
  def index
      @user = User.find(params[:user_id])
      @addresses = @user.addresses
  end
  
  def new
      @user = User.find(params[:user_id])
      @address = @user.addresses.build
  end
  
  def create
      @user = User.find(params[:user_id])
      @address = @user.addresses.build(params[:address])
      if @address.save
        redirect_to user_addresses_path(@user)
      else 
        render action: "new"
      end
  end
  
  def edit
      @user = User.find(params[:user_id])
      @address = @user.addresses.find(params[:id])
  end
  
  def update
      @user = User.find(params[:user_id])
      @address = @user.addresses.find(params[:id])
      if @address.update_attributes(params[:address])
        redirect_to user_addresses_path(@user)
      else
        render action: "edit"
      end
  end
  
  def destroy
    user = User.find(params[:user_id])
    @address = user.addresses.find(params[:id])
    @address.destroy
    respond_to do |format|    
      format.json { head :no_content }
    end
  end
  
end
