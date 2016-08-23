class AddColumnToVote < ActiveRecord::Migration
  def change
    add_column :votes, :tipo, :string
  end
end
