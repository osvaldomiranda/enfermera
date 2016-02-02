class AddIncomToFee < ActiveRecord::Migration
  def change
    add_reference :fees, :income, index: true
  end
end
