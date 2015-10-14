class CreateIndependents < ActiveRecord::Migration
  def change
    create_table :independents do |t|
      t.string :tipo_rentista
      t.string :tipo_actividad
      t.string :giro_actividad
      t.string :fecha_inicio_rubro
      t.string :fecha_inicio_actividad
      t.string :nombre_empleador_anterior
      t.string :cargo
      t.string :antiguedad
      t.references :person, index: true

      t.timestamps
    end
  end
end
