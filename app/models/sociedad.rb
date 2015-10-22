class Sociedad < ActiveRecord::Base
  belongs_to :person

   validates :rut, :rut_format => true
 
  TIPOSOCIEDAD=['Limitada','SPA']
  def self.tiposociedad_options_for_select
    #TIPOSOCIEDAD.to_enum.with_index(0).to_a
    TIPOSOCIEDAD.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
