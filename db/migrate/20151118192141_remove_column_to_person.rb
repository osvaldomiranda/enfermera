class RemoveColumnToPerson < ActiveRecord::Migration
  def change
    remove_column :people, :first_name
    remove_column :people, :last_name
    remove_column :people, :gender
    remove_column :people, :nationality
    remove_column :people, :economic_activity
    remove_column :people, :education
    remove_column :people, :origin_country
    remove_column :people, :resident_country
    remove_column :people, :profession
    remove_column :people, :dependents
    remove_column :people, :university
    remove_column :people, :number_of_children
    remove_column :people, :marital_status
    remove_column :people, :matrimonial_regime
    remove_column :people, :date_birth
    remove_column :people, :employmentsituation
  end
end
