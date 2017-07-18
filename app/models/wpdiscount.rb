class Wpdiscount < ActiveRecord::Base
  belongs_to :workplace

  mount_uploader :discountfile, WpfileUploader 
end
