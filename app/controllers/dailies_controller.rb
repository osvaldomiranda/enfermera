class DailiesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_daily, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @dailies = Daily.all
    respond_with(@dailies)
  end

  def show
    respond_with(@daily)
  end

  def new
    @head_daily_id = HeadDaily.find_by_numero(params[:head_daily_numero]).id
    @tipo = params[:tipo]
    @daily = Daily.new
    respond_modal_with(@daily)
  end

  def edit
  end

  def create
    @head_daily = HeadDaily.find(daily_params[:head_daily_id])
    @daily = Daily.new(daily_params)
    @daily.save
    render '/head_dailies/show'
  end

  def update
    @daily.update(daily_params)
    respond_with(@daily)
  end

  def destroy
    @daily.destroy
    respond_with(@daily)
  end

  private
    def set_daily
      @daily = Daily.find(params[:id])
    end

    def daily_params
      params.require(:daily).permit(:numero, :fecha, :cost_center_id, :account_id, :debe, :haber, :numdocumento, :detalle, :paguesea, :por, :tipo, :office_id, :income_id, :expense_id, :head_daily_id)
    end
end
