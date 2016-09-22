class AddColumToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :recibidode, :string
  end
end
