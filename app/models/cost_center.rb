class CostCenter < ActiveRecord::Base

  def self.options_for_select
    CostCenter.all.order(codigo: :asc).map {|t| ["#{t.codigo}  #{t.nombre}", t.id]}
  end 
end
