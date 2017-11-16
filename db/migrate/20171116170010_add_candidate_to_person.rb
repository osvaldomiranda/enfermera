class AddCandidateToPerson < ActiveRecord::Migration
  def change
    add_column :people, :candidate, :boolean
  end
end
