class AddColumnEstadoToPerson < ActiveRecord::Migration
  def change
    add_column :people, :estado, :string
  end
end
