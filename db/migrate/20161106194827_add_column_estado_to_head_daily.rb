class AddColumnEstadoToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :estado, :string
  end
end
