class ImageBucket < ActiveRecord::Base
  mount_uploader :image, PictureUploader 
end
