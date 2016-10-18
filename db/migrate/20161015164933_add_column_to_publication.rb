class AddColumnToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :web, :text
  end
end
