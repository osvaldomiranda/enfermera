class AddFechatermsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :fechaterms, :date
  end
end
