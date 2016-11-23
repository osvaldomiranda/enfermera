class AddFonosToPerson < ActiveRecord::Migration
  def change
    add_column :people, :telefono, :string
    add_column :people, :celular, :string
  end
end
