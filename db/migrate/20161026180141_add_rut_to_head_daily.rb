class AddRutToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :rut, :string
  end
end
