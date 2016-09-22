class AddColumsToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :paguesea, :string
    add_column :head_dailies, :por, :string
    add_column :head_dailies, :banco, :string
  end
end
