class PayrollincomeController < ApplicationController
  def index
  	@incomes = Incomes.all
  	@detail_incomes = Detail_incomes.all
  end
end
