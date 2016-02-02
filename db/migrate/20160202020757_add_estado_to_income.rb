class AddEstadoToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :estado, :string
  end
end
