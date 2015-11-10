class AddColumnToIngreso < ActiveRecord::Migration
  def change
    add_column :ingresos, :otros, :integer
  end
end
