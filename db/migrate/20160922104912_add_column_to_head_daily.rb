class AddColumnToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :mediopago, :string
  end
end
