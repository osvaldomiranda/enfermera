class ManagementController < ApplicationController
  def index
  	@incomes = Income.all
  end
end
