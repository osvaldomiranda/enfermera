class Vote < ActiveRecord::Base
  has_many :candidates
  has_many :positions
  has_many :uservotes 
  has_many :vows

  mount_uploader :filepdf417, WpfileUploader
  mount_uploader :filesigned, WpfileUploader 
end
