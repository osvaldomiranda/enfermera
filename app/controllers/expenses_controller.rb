class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
 
    @office = params[:office]  || nil
    @expenses = Expense.office(@office)

    respond_with(@expenses)
  end

  def toxls
    require 'csv'
    @office = params[:office]  || nil
    @expenses = Expense.office(@office)

    respond_to do |format|
      format.xls 
    end
  end

  def show
    respond_with(@expense)
  end

  def new
    @expense = Expense.new
    respond_with(@expense)
  end

  def edit
    respond_with(@expense)
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.fecha = DateTime.now
    @expense.user_id = current_user.id
    @expense.save
    respond_with(@expense)
  end

  def update
    @expense.update(expense_params)
    respond_with(@expense)
  end

  def destroy
    @expense.destroy
    respond_with(@expense)
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:fecha, :monto, :tipo, :document, :descripcion, :mediopago, :office_id, :user_id_id, :estado)
    end
end
