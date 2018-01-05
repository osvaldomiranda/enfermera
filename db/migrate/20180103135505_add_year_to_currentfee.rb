class AddYearToCurrentfee < ActiveRecord::Migration
  def change
    add_column :currentfees, :year, :integer
  end
end
