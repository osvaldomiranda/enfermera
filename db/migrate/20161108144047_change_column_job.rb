class ChangeColumnJob < ActiveRecord::Migration
  def change
    change_column :jobs, :descripcion, :text
  end
end
