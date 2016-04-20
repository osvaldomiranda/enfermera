class CreateCostCenters < ActiveRecord::Migration
  def change
    create_table :cost_centers do |t|
      t.string :codigo
      t.string :nombre

      t.timestamps
    end
  end
end
