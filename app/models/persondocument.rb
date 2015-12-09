class Persondocument < ActiveRecord::Base
  belongs_to :person

    mount_uploader :documento, DocumentUploader




  TIPO      = ['Curriculum', 'Curso Perfeccionamiento', 'Magister', 'Diplomado', 'Otro']
  def self.tipo_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
