class AddPaisToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :pais_origen, :string
  end
end
