class CreateDeudaDirecta < ActiveRecord::Migration
  def change
    create_table :deuda_directa do |t|
      t.string :tipo
      t.string :institucion
      t.string :cupo_aprobado
      t.string :deuda_vigente
      t.string :pago_mensual
      t.string :vencimineto
      t.references :person, index: true

      t.timestamps
    end
  end
end
