class CreateSociedads < ActiveRecord::Migration
  def change
    create_table :sociedads do |t|
      t.string :tipo
      t.string :porcentaje
      t.string :capital
      t.string :nombre
      t.string :rut
      t.references :person, index: true

      t.timestamps
    end
  end
end
