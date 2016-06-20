class AddColumnToFee < ActiveRecord::Migration
  def change
    add_column :fees, :nro_registro, :integer
  end
end
