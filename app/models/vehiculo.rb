class Vehiculo < ActiveRecord::Base
  belongs_to :person
  TIPOVEHICULO=['Auto','Moto','Camioneta']
  def self.tipovehiculo_options_for_select
    #TIPOVEHICULO.to_enum.with_index(0).to_a
    TIPOVEHICULO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
