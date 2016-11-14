class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :titulo
      t.string :descripcion
      t.string :portada
      t.string :documento

      t.timestamps
    end
  end
end
