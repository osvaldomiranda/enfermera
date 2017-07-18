class AddFilesToUserVote < ActiveRecord::Migration
  def change
    add_column :user_votes, :xmlfile, :string
    add_column :user_votes, :pngfile, :string
  end
end
