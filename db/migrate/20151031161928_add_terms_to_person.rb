class AddTermsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :terms, :string
  end
end
