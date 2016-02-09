class OfficeaccountsController < ApplicationController
  before_action :set_officeaccount, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @officeaccounts = Officeaccount.all
    @incomevalue = Officeaccount.sum(:incomevalue)
    @expensevalue = Officeaccount.sum(:expensevalue)
    @saldo = Officeaccount.sum(:incomevalue) - Officeaccount.sum(:expensevalue)
    respond_with(@officeaccounts)
  end

  def show
    respond_with(@officeaccount)
  end

  def new
    @officeaccount = Officeaccount.new
    respond_with(@officeaccount)
  end

  def edit
  end

  def create
    @officeaccount = Officeaccount.new(officeaccount_params)
    @officeaccount.save
    respond_with(@officeaccount)
  end

  def update
    @officeaccount.update(officeaccount_params)
    respond_with(@officeaccount)
  end

  def destroy
    @officeaccount.destroy
    respond_with(@officeaccount)
  end

  private
    def set_officeaccount
      @officeaccount = Officeaccount.find(params[:id])
    end

    def officeaccount_params
      params.require(:officeaccount).permit(:fecha, :tipo, :monto, :codigo, :account, :user_id, :office_id, :income_id, :expense_id)
    end
end
