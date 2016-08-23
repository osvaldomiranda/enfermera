class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.date :fecha
      t.string :votacion
      t.string :descripcion
      t.string :inicio
      t.string :termino
      t.string :estado

      t.timestamps
    end
  end
end
