class AddFechaToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :fecha_pago, :datetime
    add_column :incomes, :fecha_contable, :datetime
    add_column :incomes, :mes_cuota, :string
  end
end
