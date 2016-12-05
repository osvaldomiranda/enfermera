class AddColumsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :fecha_desde, :date
    add_column :jobs, :fecha_hasta, :date
    add_column :jobs, :num_dias, :integer
  end
end
