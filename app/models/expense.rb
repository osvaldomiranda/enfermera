class Expense < ActiveRecord::Base
  belongs_to :office
  belongs_to :user_id

  

  mount_uploader :document, DocumentUploader

  TIPO      = ['Servicios', 'Viajes', 'Arriendo', 'Representacion']
  def self.tipo_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  MEDIOPAGO      = ['Efectivo', 'Cheque', 'Transferencia']
  def self.mediopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MEDIOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
