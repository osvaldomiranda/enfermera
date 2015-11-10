class AddColumnToSpouse < ActiveRecord::Migration
  def change
    add_column :spouses, :adress, :string
    add_column :spouses, :phone, :string
    add_column :spouses, :renta, :integer
    add_column :spouses, :fechaingreso, :date
  end
end
