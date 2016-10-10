class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :titulo
      t.string :alojamiento
      t.string :estado

      t.timestamps
    end
  end
end
