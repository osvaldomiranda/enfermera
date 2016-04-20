class AddCodigoToPerson < ActiveRecord::Migration
  def change
    add_column :people, :codigo, :string
  end
end
