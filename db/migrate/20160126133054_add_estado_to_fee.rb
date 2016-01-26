class AddEstadoToFee < ActiveRecord::Migration
  def change
    add_column :fees, :estado, :string
  end
end
