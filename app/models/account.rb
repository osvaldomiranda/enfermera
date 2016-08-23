class Account < ActiveRecord::Base
  def self.options_for_select
    Account.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
  end 
end
