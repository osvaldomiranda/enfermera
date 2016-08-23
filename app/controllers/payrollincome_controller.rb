class PayrollincomeController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @incomes = Incomes.all
    @detail_incomes = Detail_incomes.all
  end
end
