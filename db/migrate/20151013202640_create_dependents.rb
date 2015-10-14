class CreateDependents < ActiveRecord::Migration
  def change
    create_table :dependents do |t|
      t.string :empleador
      t.string :rut_empleador
      t.string :giro_empresa
      t.string :direccion_empresa
      t.string :tipo_contrato
      t.string :cargo
      t.string :fecha_ingreso
      t.string :fecha_ingreso_anterior
      t.string :fecha_termino_anterior
      t.references :person, index: true

      t.timestamps
    end
  end
end
