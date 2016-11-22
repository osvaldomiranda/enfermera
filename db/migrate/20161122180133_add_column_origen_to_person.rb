class AddColumnOrigenToPerson < ActiveRecord::Migration
  def change
    add_column :people, :origen, :string
  end
end
