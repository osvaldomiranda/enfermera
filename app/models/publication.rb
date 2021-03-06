class Publication < ActiveRecord::Base
  mount_uploader :imagen, ImageUploader
  mount_uploader :documeto, FileUploader

  scope :with_tipo, -> with_tipo { where(tipo: with_tipo) if with_tipo.present?}
  scope :scheduled, -> { where('fecha_desde <= ? and fecha_hasta >= ?', DateTime.now.beginning_of_day, DateTime.now)}


  ESTADO      = ['Visible', 'No Visible']
  def self.estado_collection
    #GENDERS.to_enum.with_index(0).to_a
    ESTADO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  TIPO      = ['NOTICIA', 'YO TE CUIDO', 'EVENTO']
  def self.tipo_collection
    #GENDERS.to_enum.with_index(0).to_a
    TIPO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
