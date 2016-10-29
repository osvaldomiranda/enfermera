class AddColumnToNationalCouncil < ActiveRecord::Migration
  def change
    add_column :national_councils, :prioridad, :integer
  end
end
