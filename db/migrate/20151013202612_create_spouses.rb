class CreateSpouses < ActiveRecord::Migration
  def change
    create_table :spouses do |t|
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
      t.string :dependents
      t.string :university
      t.integer :number_of_children
      t.string :date_birth
      t.references :person, index: true

      t.timestamps
    end
  end
end
