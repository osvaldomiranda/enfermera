class AddFonoToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :telefono, :string
  end
end
