class AddColumnToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :telefono, :string
    add_column :inscriptions, :celular, :string
    add_column :inscriptions, :email, :string
  end
end
