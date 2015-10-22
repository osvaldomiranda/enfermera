class Dependent < ActiveRecord::Base
  belongs_to :person

  validates :rut_empleador, :rut_format => true

  TIPOCARGO = ['Plazo Fijo', 'Indefinido'] 
  
  def self.tipocargo_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOCARGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
