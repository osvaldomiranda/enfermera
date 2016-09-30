class AddWorkplaceToDaily < ActiveRecord::Migration
  def change
    add_reference :dailies, :workplace, index: true
  end
end
