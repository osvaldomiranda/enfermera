class PayrollexpenseController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @expenses = Expense.all
    @detail_expenses = Detail_expenses.all
  end
end
