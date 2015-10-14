class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :email
      t.string :rut
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :nationality
      t.string :economic_activity
      t.string :education
      t.string :origin_country
      t.string :resident_country
      t.string :profession
      t.integer :dependents
      t.string :university
      t.integer :number_of_children
      t.string :marital_status
      t.string :matrimonial_regime
      t.string :date_birth

      t.timestamps
    end
  end
end
