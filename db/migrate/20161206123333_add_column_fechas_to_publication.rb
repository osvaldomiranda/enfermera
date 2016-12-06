class AddColumnFechasToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :fecha_desde, :date
    add_column :publications, :fecha_hasta, :date
  end
end
