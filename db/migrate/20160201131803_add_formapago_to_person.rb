class AddFormapagoToPerson < ActiveRecord::Migration
  def change
    add_column :people, :forma_pago, :string
  end
end
