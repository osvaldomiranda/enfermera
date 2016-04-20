class DetailIncome < ActiveRecord::Base
  belongs_to :account
  belongs_to :workplace
  belongs_to :cost_center
  belongs_to :income
end
