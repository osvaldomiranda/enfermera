class AddWpToInscription < ActiveRecord::Migration
  def change
    add_reference :inscriptions, :workplace, index: true
  end
end
