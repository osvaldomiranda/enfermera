class AddNewColumnToDaily < ActiveRecord::Migration
  def change
    add_column :dailies, :banco, :string
  end
end
