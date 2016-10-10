class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :titulo
      t.string :texto
      t.string :resumen
      t.string :imagen
      t.string :tipo
      t.string :documeto
      t.string :estado

      t.timestamps
    end
  end
end
