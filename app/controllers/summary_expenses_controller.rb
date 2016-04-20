class SummaryExpensesController < ApplicationController
  def index
  	@expenses = Expense.group(:tipo).sum(:monto)
  	
  end
end
