class AddVowFileToVow < ActiveRecord::Migration
  def change
    add_column :vows, :vowfile, :string
  end
end
