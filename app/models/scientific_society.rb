class ScientificSociety < ActiveRecord::Base
  mount_uploader :logo, PictureUploader
end
