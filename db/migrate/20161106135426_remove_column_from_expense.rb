class RemoveColumnFromExpense < ActiveRecord::Migration
  def change
  	remove_column :expenses, :user_id_id
  end
end
