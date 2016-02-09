class Expense < ActiveRecord::Base
  belongs_to :office
  belongs_to :user_id
end
