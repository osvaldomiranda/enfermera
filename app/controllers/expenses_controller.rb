class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
 
    @office = params[:office]  || nil
    @expenses = Expense.office(@office).order('created_at DESC').page(params[:page]).per_page(20) 

    respond_with(@expenses)
  end

  def toxls
    require 'csv'
    @office = params[:office]  || nil
    @expenses = Expense.office(@office).order('created_at DESC')

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
    @expense = Expense.new
    @expense.fecha = Date.parse(expense_params[:fecha])
    @expense.monto = expense_params[:monto]
    @expense.tipo  = expense_params[:tipo]
    @expense.mediopago = expense_params[:mediopago]
    @expense.descripcion = expense_params[:descripcion]
    @expense.office_id = expense_params[:office_id]
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
