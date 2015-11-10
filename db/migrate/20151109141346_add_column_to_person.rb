class AddColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :employmentsituation, :string
  end
end
