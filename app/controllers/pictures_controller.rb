
class PicturesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @gallery = Gallery.find(params[:gallery_id])
    @pictures = @gallery.pictures
    respond_to do |format|
      format.html
      format.json { render json: @pictures }
    end
  end
  
  def show
    @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @picture }
    end
  end
  
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build
    respond_to do |format|
      format.html
      format.json { render json: @picture }
    end
  end
  
  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    p_attr = params[:picture]
    p_attr[:image] = params[:picture][:image].first if params[:picture][:image].class == Array
    @gallery = @kitchen.galleries.find(params[:gallery_id])
    @picture = @gallery.pictures.build(p_attr)
  
    if @picture.save
      @picture.make_default(@gallery.id)
      respond_to do |format|
        format.html {
          render :json => [@picture.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end
  
  def edit
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])
    @image_flag_id = params[:image_flag_id]
  end
  
  def update
    @kitchen = Kitchen.find(params[:kitchen_id]) 
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        @kitchen.update_attribute(:cover_pic_id, @picture.id) if params[:image_flag_id] == '18'
        @kitchen.update_attribute(:profile_pic_id, @picture.id) if params[:image_flag_id] == '53'
        format.html { redirect_to kitchen_path(@kitchen), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])
    if @picture.destroy
       @picture.make_default(@gallery.id)
       @kitchen.update_attribute(:cover_pic_id, nil) if (!@kitchen.cover_pic_id.nil?) && (@kitchen.cover_pic_id == @picture.id)
       @kitchen.update_attribute(:profile_pic_id, nil) if (!@kitchen.profile_pic_id.nil?) && (@kitchen.profile_pic_id == @picture.id)
    end
    respond_to do |format|
      format.html { redirect_to gallery_pictures_url }
      format.js
    end
  end
  
end
