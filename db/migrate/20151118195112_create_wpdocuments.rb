class CreateWpdocuments < ActiveRecord::Migration
  def change
    create_table :wpdocuments do |t|
      t.string :nombre
      t.string :tipo
      t.string :documento
      t.references :workplace, index: true

      t.timestamps
    end
  end
end
