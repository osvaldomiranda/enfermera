class AddColumnToDaily < ActiveRecord::Migration
  def change
    add_reference :dailies, :head_daily, index: true
  end
end
