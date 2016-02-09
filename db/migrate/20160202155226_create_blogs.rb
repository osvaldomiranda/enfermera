class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :titulo
      t.text :descripcion
      t.string :imagen
      t.string :documento
      t.string :estado

      t.timestamps
    end
  end
end
