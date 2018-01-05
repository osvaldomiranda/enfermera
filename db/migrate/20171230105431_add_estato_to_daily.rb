class AddEstatoToDaily < ActiveRecord::Migration
  def change
    add_column :dailies, :estado, :string
  end
end
