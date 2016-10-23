class AddWebToNationalCouncil < ActiveRecord::Migration
  def change
    add_column :national_councils, :web, :text
  end
end
