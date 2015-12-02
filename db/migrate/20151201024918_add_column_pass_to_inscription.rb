class AddColumnPassToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :password, :string
    add_column :inscriptions, :password_confirmation, :string
  end
end
