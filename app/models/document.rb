class Document < ActiveRecord::Base
  belongs_to :person

  mount_uploader :file, FileUploader
end
