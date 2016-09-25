class AddNumChequeToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :numcheque, :string
  end
end
