class AddDocumentoToHeadDaily < ActiveRecord::Migration
  def change
    add_column :head_dailies, :documento, :string
  end
end
