class AddWorkplaceToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :workplace, index: true
  end
end
