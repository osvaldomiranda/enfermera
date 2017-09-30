class AddSerSaludToWorkplace < ActiveRecord::Migration
  def change
    add_column :workplaces, :serv_salud, :string
  end
end
