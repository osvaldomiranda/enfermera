class CreateRegionalCouncils < ActiveRecord::Migration
  def change
    create_table :regional_councils do |t|
      t.string :nombre
      t.string :cargo
      t.string :email
      t.string :fono
      t.references :office, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end
