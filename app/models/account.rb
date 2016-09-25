class Account < ActiveRecord::Base
  def self.options_for_select
    Account.all.order(codigo: :asc).map {|t| ["#{t.codigo}  #{t.nombre}", t.id]}
  end 
end
