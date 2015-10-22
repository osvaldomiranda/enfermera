class Direccion < ActiveRecord::Base
  belongs_to :person

  TIPODIRECCION = ['Residencial', 'Comercial']
  TIPOVIVIENDA  = ['Propia con deuda','Propia sin deuda','Arrendada','Familiar','Comercial']
  COMUNA        = ['Santiago','Cerrillos','Cerro Navia','Conchali','El Bosque','Estacion Central','Huechuraba','Independencia','La Cisterna','La Florida','La Granja','La Pintana','La Reina','Las Condes','Lo Barnechea','Lo Espejo','Lo Prado','Macul','Maipu','Nunoa','Pedro Aguirre Cerda','Penalolen','Providencia','Pudahuel','Quilicura','Quinta Normal','Recoleta','Renca','San Joaquin','San Miguel','San Ramon','Vitacura','Puente Alto','Pirque','San Jose de Maipo','Colina','Lampa','Tiltil','San Bernardo','Buin','Calera de Tango','Paine','Melipilla','Alhue','Curacavi','Maria Pinto','San Pedro','Talagante','El Monte','Isla de Maipo','Padre Hurtado','Penaflor']


  CIUDAD        = ['Santiago']

  def self.ciudad_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    CIUDAD.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.comuna_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    COMUNA.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.tipodireccion_options_for_select
    #TIPODIRECCION.to_enum.with_index(0).to_a
    TIPODIRECCION.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 


  def self.tipovivienda_options_for_select
    #TIPOVIVIENDA.to_enum.with_index(0).to_a
    TIPOVIVIENDA.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

end
