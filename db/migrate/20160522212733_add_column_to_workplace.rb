class AddColumnToWorkplace < ActiveRecord::Migration
  def change
    add_column :workplaces, :cod_wp, :string
  end
end
