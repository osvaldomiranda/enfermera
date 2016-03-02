class ConsignmentController < ApplicationController
  before_filter :authenticate_user!
  def index
    @incomes = Income.where(estado: "CONFIRMADO")
    @total = Income.where(estado: "CONFIRMADO").sum(:monto)
    @remesa = @total*0.35
  end
end
