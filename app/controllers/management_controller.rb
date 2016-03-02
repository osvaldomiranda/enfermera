class ManagementController < ApplicationController
  before_filter :authenticate_user!
  def index
    @incomes = Income.all
  end
end
