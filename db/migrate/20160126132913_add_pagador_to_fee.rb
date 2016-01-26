class AddPagadorToFee < ActiveRecord::Migration
  def change
    add_column :fees, :pagador, :string
    add_column :fees, :mes_cuota, :string
  end
end
