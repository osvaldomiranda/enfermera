class UserVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote

  mount_uploader :xmlfile, WpfileUploader 


end
