class AddUserToInscription < ActiveRecord::Migration
  def change
    add_reference :inscriptions, :user, index: true
  end
end
