class UserAlowVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote
end
