class AddColumnOrigenToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :origen, :string
  end
end
