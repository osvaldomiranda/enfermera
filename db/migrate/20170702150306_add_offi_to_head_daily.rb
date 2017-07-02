class AddOffiToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :folio_office, :integer
  end
end
