class Officeaccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :office
  belongs_to :income
  belongs_to :expense
end
