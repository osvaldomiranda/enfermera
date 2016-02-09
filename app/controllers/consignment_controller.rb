class ConsignmentController < ApplicationController
  def index
  	@incomes = Income.where(estado: "CONFIRMADO")
  	@total = Income.where(estado: "CONFIRMADO").sum(:monto)
  	@remesa = @total*0.35
  end
end
