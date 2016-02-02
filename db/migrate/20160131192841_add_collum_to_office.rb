class AddCollumToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :codigo, :string
    add_column :offices, :calle, :string
    add_column :offices, :numero, :string
  end
end
