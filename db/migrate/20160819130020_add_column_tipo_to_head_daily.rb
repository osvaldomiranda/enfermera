class AddColumnTipoToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :tipo, :string
  end
end
