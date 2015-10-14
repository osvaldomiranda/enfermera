class CreateBienesRaices < ActiveRecord::Migration
  def change
    create_table :bienes_raices do |t|
      t.string :tipo
      t.string :direccion
      t.string :valor_comercial
      t.string :rol
      t.string :hipoteca_banco
      t.references :person, index: true

      t.timestamps
    end
  end
end
