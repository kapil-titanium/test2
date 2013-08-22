
class DishesController < ApplicationController
  load_and_authorize_resource
  
  def index 
    @kitchen = Kitchen.find(params[:kitchen_id])
    @dishes = @kitchen.dishes if @kitchen.present? 
    @courses = Course.all
    @dish = @kitchen.dishes.build if @kitchen.present?
  end
  
  def new
    @kitchen = Kitchen.find(params[:kitchen_id])
    @dish = @kitchen.dishes.build  if @kitchen.present?
    @courses = Course.all
  end
  
  def create
    @kitchen = Kitchen.find(params[:kitchen_id]) 
    if @kitchen.dishes.build(params[:dish]).save
      redirect_to kitchen_dishes_path(@kitchen)
    else
     redirect_to :back
    end if  @kitchen.present?
  end  
  
  def show
    @kitchen = Kitchen.find(params[:kitchen_id])
    @dish = Dish.find(params[:dish_id])
  end
  
  def edit
    @kitchen = Kitchen.find(params[:kitchen_id])
    @dish = Dish.find(params[:id])
    @courses = Course.all
  end
  
  def update
    @kitchen = Kitchen.find(params[:kitchen_id])
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(params[:dish])
       redirect_to kitchen_dishes_path(@kitchen)
    else
      redirect_to :back
    end
  end
  
  def delete
    @kitchen = Kitchen.find(params[:kitchen_id])
    Dish.find(params[:dish_id]).destroy
    redirect_to kitchen_dishes_path(@kitchen.id)
  end
  
  def get_dish_for_edit
    @dish = Dish.find(params[:dish_id])
    @kitchen = @dish.kitchen
    @courses = Course.all
    render :partial => 'edit_dish', :locals => {:dish => @dish, :kitchen => @kitchen, :courses => @courses}
  end

end
