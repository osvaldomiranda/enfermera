class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :titulo
      t.string :descripcion
      t.string :contacto
      t.string :estado

      t.timestamps
    end
  end
end
