class AddFormapagoToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :forma_pago, :string
  end
end
