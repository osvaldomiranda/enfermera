class AddCompleteEducToPerson < ActiveRecord::Migration
  def change
    add_column :people, :completeeduc, :string
  end
end
