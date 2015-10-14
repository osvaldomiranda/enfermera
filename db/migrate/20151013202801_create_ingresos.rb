class CreateIngresos < ActiveRecord::Migration
  def change
    create_table :ingresos do |t|
      t.string :sueldo_fijo_mes
      t.string :sueldo_variable_mes
      t.string :arriendo
      t.string :vtas_anuales
      t.string :declaracion_renta
      t.string :honorarios_mes
      t.string :cta_cte
      t.string :banco
      t.references :person, index: true

      t.timestamps
    end
  end
end
