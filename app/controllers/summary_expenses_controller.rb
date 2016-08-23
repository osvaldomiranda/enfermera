class SummaryExpensesController < ApplicationController
before_filter :authenticate_user! 	
  def index
  	@expenses = Expense.group(:tipo).sum(:monto)
  	
  end
end
