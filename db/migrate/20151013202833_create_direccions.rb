class CreateDireccions < ActiveRecord::Migration
  def change
    create_table :direccions do |t|
      t.string :tipo
      t.string :calle_num_depto
      t.string :comuna
      t.string :ciudad
      t.string :telefono
      t.string :celular
      t.string :codigo_postal
      t.string :tipo_vivienda
      t.string :dividendo_arriendo
      t.string :casilla
      t.string :num_correo
      t.string :ciudad
      t.references :person, index: true

      t.timestamps
    end
  end
end
