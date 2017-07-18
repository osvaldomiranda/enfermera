class AddTokenToUserVote < ActiveRecord::Migration
  def change
    add_column :user_votes, :token, :string
  end
end
