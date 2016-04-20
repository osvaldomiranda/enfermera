class DetailIncomesController < ApplicationController
  before_action :set_detail_income, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @detail_incomes = DetailIncome.all
    respond_with(@detail_incomes)
  end

  def show
    respond_with(@detail_income)
  end

  def new
    @detail_income = DetailIncome.new
    respond_with(@detail_income)
  end

  def edit
  end

  def create
    @detail_income = DetailIncome.new(detail_income_params)
    @detail_income.save
    respond_with(@detail_income)
  end

  def update
    @detail_income.update(detail_income_params)
    respond_with(@detail_income)
  end

  def destroy
    @detail_income.destroy
    respond_with(@detail_income)
  end

  private
    def set_detail_income
      @detail_income = DetailIncome.find(params[:id])
    end

    def detail_income_params
      params.require(:detail_income).permit(:pcontable, :fcontable, :tipo_comprobante, :mescuota, :detalle, :debe, :haber, :obeservacion, :account_id, :workplace_id, :cost_center_id, :income_id)
    end
end
