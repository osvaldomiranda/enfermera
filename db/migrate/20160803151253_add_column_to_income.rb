class AddColumnToIncome < ActiveRecord::Migration
  def change
    add_reference :incomes, :office, index: true
  end
end
