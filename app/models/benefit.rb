class Benefit < ActiveRecord::Base
  belongs_to :office

  mount_uploader :imagen, PictureUploader
end
