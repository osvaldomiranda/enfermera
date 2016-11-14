class AddColumnToMagazine < ActiveRecord::Migration
  def change
    add_column :magazines, :fecha, :datetime
  end
end
