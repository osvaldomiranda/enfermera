class AddNombresToPerson < ActiveRecord::Migration
  def change
    add_column :people, :nombres, :string
    add_column :people, :nro_registro, :integer
    add_column :people, :apellido_paterno, :string
    add_column :people, :apellido_materno, :string
    add_column :people, :sexo, :string
    add_column :people, :nacionalidad, :string
    add_column :people, :fecha_inscripcion, :date
    add_column :people, :direccion, :string
    add_column :people, :ciudad, :string
    add_column :people, :universidad, :string
    add_column :people, :fecha_titulo, :date
    add_column :people, :lugar_trabajo, :string
    add_column :people, :tipo_contrato, :string
  end
end
