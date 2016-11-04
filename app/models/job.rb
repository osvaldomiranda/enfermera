class Job < ActiveRecord::Base

  validates :titulo, presence: true
  validates :contacto, presence: true

  ESTADO = ['VISIBLE', 'OCULTO']

  def self.estado_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    ESTADO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

end
