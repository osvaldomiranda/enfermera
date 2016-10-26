class AddFechaToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :fecha_contable, :datetime
  end
end
