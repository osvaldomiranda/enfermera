class DetailExpense < ActiveRecord::Base
  belongs_to :account
  belongs_to :cost_center
  belongs_to :expense
end
