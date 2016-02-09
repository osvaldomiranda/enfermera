class AddMontosToOfficeaccount < ActiveRecord::Migration
  def change
    add_column :officeaccounts, :incomevalue, :float
    add_column :officeaccounts, :expensevalue, :float
  end
end
