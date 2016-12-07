class Country < ActiveRecord::Base
  def self.for_select
    Country.order(:nombre).map{|t| [t.nombre, t.nombre.upcase]}
  end 
end
