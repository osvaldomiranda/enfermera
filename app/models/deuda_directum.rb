class DeudaDirectum < ActiveRecord::Base
  belongs_to :person

  TIPODEUDADIRECTAS=['Hipotecaria','Consumo','Tarjeta Credito','Linea Sobregiro']

  def self.tipodeuda_options_for_select
    #TIPODEUDADIRECTAS.to_enum.with_index(0).to_a
    TIPODEUDADIRECTAS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end
end
