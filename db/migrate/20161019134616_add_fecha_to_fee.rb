class AddFechaToFee < ActiveRecord::Migration
  def change
    add_column :fees, :fecha_contable, :datetime
  end
end
