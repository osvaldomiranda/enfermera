class AddNombreToPerson < ActiveRecord::Migration
  def change
    add_column :people, :nombre_completo, :string
  end
end
