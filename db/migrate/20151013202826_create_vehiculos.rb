class CreateVehiculos < ActiveRecord::Migration
  def change
    create_table :vehiculos do |t|
      t.string :tipo
      t.string :marca
      t.string :modelo
      t.string :agno
      t.string :patente
      t.string :valor_comercia
      t.string :prenda_afavor
      t.references :person, index: true

      t.timestamps
    end
  end
end
