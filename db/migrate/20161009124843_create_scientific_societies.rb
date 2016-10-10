class CreateScientificSocieties < ActiveRecord::Migration
  def change
    create_table :scientific_societies do |t|
      t.string :nombre
      t.text :descripcion
      t.string :logo
      t.string :direccion
      t.string :telefono
      t.string :contacto
      t.string :web_url

      t.timestamps
    end
  end
end
