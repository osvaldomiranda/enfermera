class CreateUniversitarios < ActiveRecord::Migration
  def change
    create_table :universitarios do |t|
      t.string :email
      t.string :universidad
      t.string :carrera
      t.string :encurso
      t.string :renta_familiar
      t.string :nombre_padre
      t.string :rut_padre
      t.references :person, index: true

      t.timestamps
    end
  end
end
