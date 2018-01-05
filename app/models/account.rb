class Account < ActiveRecord::Base
  has_many :dailies

  def self.options_for_select
    Account.all.order(nombre: :asc).map {|t| ["#{t.nombre}", t.id]}
  end 

end
