class CreateDeudaIndirecta < ActiveRecord::Migration
  def change
    create_table :deuda_indirecta do |t|
      t.string :tipo
      t.string :institucion
      t.string :deuda_vigente
      t.string :razon_social
      t.string :rut
      t.references :person, index: true

      t.timestamps
    end
  end
end
