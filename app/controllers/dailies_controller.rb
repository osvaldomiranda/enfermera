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
    @head_daily = HeadDaily.find_by_numero(params[:head_daily_numero])
    @head_daily_id = @head_daily.id
    @tipo = params[:tipo]
    @daily = Daily.new
    if @head_daily.dailies.last.present?
      @daily = @head_daily.dailies.last
    end

    respond_modal_with(@daily)
  end

  def edit
    respond_modal_with(@daily)
  end

  def create
    @head_daily = HeadDaily.find(daily_params[:head_daily_id])
    @daily = Daily.new(daily_params)
    @daily.save
    render '/head_dailies/show'
  end

  def update
    @head_daily = @daily.head_daily
    params[:daily][:head_daily_id] = @head_daily.id
    params[:daily][:tipo] = @head_daily.tipo
    @daily.update(daily_params)
    render '/head_dailies/show'
  end

  def destroy
    @head_daily = @daily.head_daily
    @daily.destroy
    render '/head_dailies/show'
  end

  private
    def set_daily
      @daily = Daily.find(params[:id])
    end

    def daily_params
      params.require(:daily).permit(:numero, :fecha, :cost_center_id, :account_id, :debe, :haber, :numdocumento, :detalle, :paguesea, :por, :tipo, :office_id, :income_id, :expense_id, :head_daily_id)
    end
end
