class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.string :nombre
      t.string :ciudad
      t.string :region

      t.timestamps
    end
  end
end
