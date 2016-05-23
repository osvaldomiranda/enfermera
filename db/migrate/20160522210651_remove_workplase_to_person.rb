class RemoveWorkplaseToPerson < ActiveRecord::Migration
  def change
    remove_column :people, :workplase_id, :integer
  end
end
