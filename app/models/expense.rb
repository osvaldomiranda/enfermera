# encoding: utf-8
class Expense < ActiveRecord::Base
  belongs_to :office
  belongs_to :user

  mount_uploader :document, DocumentUploader

  validates :monto, presence: true
  validates :tipo, presence: true
  validates :mediopago, presence: true
  validates :office_id, presence: true

  scope :office, -> office { where(office_id: office) if office.present?}


TIPO      = [
'SUELDOS (SECRETARIA)',
'HORAS EXTRAORDINARIAS',
'AGUINALDOS Y BONOS',
'FINIQUITOS',
'LEY ACCIDENTES DEL TRABAJO',
'HONORARIOS',
'HONORARIOS ESPORADICOS',
'LUZ',
'AGUA',
'TELEFONO',
'GAS',
'FRANQUEO',
'ARTICULOS DE OFICINA',
'ARTICULOS DE ASEO',
'IMPUESTOS Y OTROS',
'MANTENCION',
'MANTENCION EQUIPOS',
'MANTENCION SEDES',
'FOTOCOPIAS',
'SEGUROS',
'ARRIENDOS',
'EQUIPOS COMPUTACIONALES',
'GASTOS NO ESPECIFICADOS',
'CAPACITACION PERSONAL',
'VIATICOS',
'PASAJES Y MOVILIZACION REGIONALES',
'PASAJE AEREO Y TERRESTRE CONSEJOS NAC.',
'HOTELES Y ALOJAMIENTOS',
'ALIMENTACION Y CENAS',
'PRESENTES (Corona de Caridad) y (Flores difunto)',
'SERVICIOS DE ONCES',
'GASTOS POR ASAMBLEA REGIONAL',
'APORTES VARIOS (Aviso de Defunción)',
'PRESTAMOS BIENESTAR',
'GASTOS VARIOS',
'PUBLICACIONES VARIAS',
'IMPRESOS',
'ENVIO POR PAGOS DIRECTOS',
'CAJA CHICA',
'GASTOS ACCION GREMIAL (Paro)',
'GASTOS FINANCIEROS' ]

  
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
