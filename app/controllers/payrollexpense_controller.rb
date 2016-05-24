class PayrollexpenseController < ApplicationController
  def index
  	@expenses = Expense.all
  	@detail_expenses = Detail_expenses.all
  end
end
