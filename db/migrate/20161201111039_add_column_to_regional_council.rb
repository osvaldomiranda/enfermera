class AddColumnToRegionalCouncil < ActiveRecord::Migration
  def change
    add_column :regional_councils, :web, :text
  end
end
