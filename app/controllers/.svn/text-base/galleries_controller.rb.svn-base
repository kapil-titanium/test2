
class GalleriesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.build
  end
  
  def show
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:id])
    @picture = @gallery.pictures.build
    @pictures = Picture.order("id asc").find(:all, :conditions  => [ 'gallery_id = ?', @gallery.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end
  
  def new
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end
  
  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = Gallery.new(params[:kitchen][:gallery])
    @gallery.kitchen_id = @kitchen.id
    
    respond_to do |format|
      if @gallery.save
         format.html { redirect_to kitchen_galleries_path(@kitchen), notice: 'Gallery was successfully created.' }
         format.json { render json: kitchen_galleries_path(@kitchen), status: :created, location: kitchen_galleries_path(@kitchen) }
      else
         format.html { render action: "new" }
         format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:id])
  end
  
  def update
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:kitchen][:gallery])
         format.html { redirect_to kitchen_galleries_path(@kitchen), notice: 'Gallery was successfully updated.' }
         format.json { head :no_content }
      else
         format.html { render action: "edit" }
         format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @kitchen = Kitchen.find(params[:kitchen_id])
    @gallery = @kitchen.galleries.find(params[:id])
    cover_pic_flag = 0
    profile_pic_flag = 0
    @gallery.pictures.each do |picture|
      cover_pic_flag = 1 if (!@kitchen.cover_pic_id.nil?) && (@kitchen.cover_pic_id == picture.id)
      profile_pic_flag = 1 if (!@kitchen.profile_pic_id.nil?) && (@kitchen.profile_pic_id == picture.id)
    end
    if @gallery.destroy
       @kitchen.update_attribute(:cover_pic_id, nil) if cover_pic_flag == 1
       @kitchen.update_attribute(:profile_pic_id, nil) if profile_pic_flag == 1
    end
    respond_to do |format|
      # format.html { redirect_to @gallery }
      format.json { head :no_content }
    end
  end
  
  def add_pictures
    @kitchen = Kitchen.find(params[:kitchen_id])
    p_attr = params[:kitchen]
    p_attr[:image] = params[:kitchen][:image].first if params[:kitchen][:image].class == Array
    
    @gallery = @kitchen.galleries.find_by_gallery_name(DEFAULT_GALLERY_NAME)
    @gallery = @kitchen.galleries.find(params[:gallery_id]) if !params[:gallery_id].blank?
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
  
end
