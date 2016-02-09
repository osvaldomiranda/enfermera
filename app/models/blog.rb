class Blog < ActiveRecord::Base
  mount_uploader :documento, DocumentUploader 
  mount_uploader :imagen, DocumentUploader 

  ESTADO      = ['Visible', 'No Visible']
  def self.estado_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    ESTADO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
