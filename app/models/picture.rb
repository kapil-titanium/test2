class Picture < ActiveRecord::Base
  
  attr_accessible :description, :gallery_id, :dish_id, :meal_id, :image, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :gallery
  belongs_to :meal
  
  mount_uploader :image, ImageUploader

  after_update :crop_image

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }
  end

  def crop_image
    return if image.blank?
    image.recreate_versions! if crop_x.present?
    current_version = self.image.current_path
    large_version = "#{Rails.root}/public" + self.image.versions[:large].to_s

    FileUtils.rm(current_version)
    FileUtils.cp(large_version, current_version)
  end
  
  def make_default(gallery_id)
    gallery = Gallery.find(gallery_id)
    pictures = Picture.order("id asc").find(:all, :conditions  => [ 'gallery_id = ?', gallery.id ])
    if pictures != []
      gallery.cover = pictures.last.id
      gallery.save
    end
  end
  
end