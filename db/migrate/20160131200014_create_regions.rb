class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :codigo
      t.string :nombre

      t.timestamps
    end
  end
end
