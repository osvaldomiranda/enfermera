class CreateInscriptions < ActiveRecord::Migration
  def change
    create_table :inscriptions do |t|
      t.string :nro_registro
      t.string :rut
      t.string :nombres
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :sexo
      t.string :nacionalidad
      t.date :fecha_inscripcion
      t.string :direccion
      t.string :ciudad
      t.string :universidad
      t.date :fecha_titulo
      t.string :tipo_contrato
      t.string :estado
      t.date :fecha_solicitud

      t.timestamps
    end
  end
end
