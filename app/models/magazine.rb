class Magazine < ActiveRecord::Base
  mount_uploader :documento, DocumentUploader
  mount_uploader :portada, DocumentUploader 

  validates :titulo, :documento, :portada, presence: true
end
