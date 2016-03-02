class IncomesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @incomes = Income.all
    respond_with(@incomes)
  end

  def show
    respond_with(@income)
  end

  def new
    @income = Income.new
    respond_with(@income)
  end

  def edit
  end

  def create
    @income = Income.new(income_params)
    @income.save
    respond_with(@income)
  end

  def update
    @income.update(income_params)
    respond_with(@income)
  end

  def feeforincome
    @income = Income.find(params[:id])
    respond_modal_with(@income)
  end

  def destroy
    @income.destroy
    respond_with(@income)
  end

  private
    def set_income
      @income = Income.find(params[:id])
    end

    def income_params
      params.require(:income).permit(:fecha, :monto, :tipo, :document, :banco, :mediopago, :person_id, :workplace_id, :user_id)
    end
end
