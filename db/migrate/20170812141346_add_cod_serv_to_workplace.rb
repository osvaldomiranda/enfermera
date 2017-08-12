class AddCodServToWorkplace < ActiveRecord::Migration
  def change
    add_column :workplaces, :cod_serv_salud, :string
  end
end
