class CostCenter < ActiveRecord::Base

  def self.options_for_select
    CostCenter.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
  end 
end
