class AddCollumToWorkplace < ActiveRecord::Migration
  def change
    add_column :workplaces, :codigo, :string
    add_column :workplaces, :telefono, :string
    add_column :workplaces, :email, :string
    add_column :workplaces, :calle, :string
    add_column :workplaces, :numero, :string
    add_reference :workplaces, :office, index: true
  end
end
