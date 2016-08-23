class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :cargo
      t.references :vote, index: true

      t.timestamps
    end
  end
end
