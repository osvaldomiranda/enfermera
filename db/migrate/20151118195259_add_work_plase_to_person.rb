class AddWorkPlaseToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :workplase, index: true
  end
end
