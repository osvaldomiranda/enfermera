class DetailExpensesController < ApplicationController
  before_action :set_detail_expense, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @detail_expenses = DetailExpense.all
    respond_with(@detail_expenses)
  end

  def show
    respond_with(@detail_expense)
  end

  def new
    @detail_expense = DetailExpense.new
    respond_with(@detail_expense)
  end

  def edit
  end

  def create
    @detail_expense = DetailExpense.new(detail_expense_params)
    @detail_expense.save
    respond_with(@detail_expense)
  end

  def update
    @detail_expense.update(detail_expense_params)
    respond_with(@detail_expense)
  end

  def destroy
    @detail_expense.destroy
    respond_with(@detail_expense)
  end

  private
    def set_detail_expense
      @detail_expense = DetailExpense.find(params[:id])
    end

    def detail_expense_params
      params.require(:detail_expense).permit(:numcomprobante, :debe, :haber, :paguesea, :por, :observacion, :account_id, :cost_center_id, :expense_id)
    end
end
