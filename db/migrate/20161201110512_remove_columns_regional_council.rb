class RemoveColumnsRegionalCouncil < ActiveRecord::Migration
  def change
    remove_column :regional_councils, :person_id
    remove_column :regional_councils, :nombre
    remove_column :regional_councils, :cargo
    remove_column :regional_councils, :email
    remove_column :regional_councils, :fono
  end
end
