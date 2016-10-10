class Publication < ActiveRecord::Base
  mount_uploader :imagen, PictureUploader
end
