class Vow < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :position
  belongs_to :vote
  belongs_to :workplace
end
