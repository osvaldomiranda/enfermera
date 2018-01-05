class DailiesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_daily, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cuenta = params[:cuenta] || nil
    @tipo = params[:tipo] || nil
    if params["/dailies"].present?
      @numero = params["/dailies"][:numero] || nil 
      @fecha_desde = params["/dailies"][:fecha_desde] || nil
      @fecha_hasta = params["/dailies"][:fecha_hasta] || nil
    end
    if @fecha_desde.present? && @fecha_hasta.present?
      fdesde = DateTime.parse(@fecha_desde)
      fhasta = DateTime.parse(@fecha_hasta)
      @dailies = Daily.with_tipo(@tipo).with_cuenta(@cuenta).with_numero(@numero).where(:fecha => fdesde..fhasta).order(id: :desc).page(params[:page]).per_page(20) 
    else  
      @dailies = Daily.with_tipo(@tipo).with_cuenta(@cuenta).with_numero(@numero).order(id: :desc).page(params[:page]).per_page(20) 
    end
    respond_with(@dailies)
  end

  

  def toxls
    require 'csv'
    @cuenta = params[:cuenta] || nil
    @numero = params[:numero] || nil
    @tipo = params[:tipo] || nil
    @fecha_desde = params[:fecha_desde] || nil
    @fecha_hasta = params[:fecha_hasta] || nil

    if @fdesde.present? && @fhasta.present?
      fdesde = DateTime.parse(@fecha_desde)
      fhasta = DateTime.parse(@fecha_hasta)
      @dailies = Daily.with_tipo(@tipo).with_cuenta(@cuenta).with_numero(@numero).where(:fecha => fdesde..fhasta).order(id: :desc)
    else  
      @dailies = Daily.with_tipo(@tipo).with_cuenta(@cuenta).with_numero(@numero).order(id: :desc)
    end

    respond_to do |format|
      format.xls 
    end
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
      daily_last = @head_daily.dailies.last

      @daily.fecha = daily_last.fecha
      @daily.cost_center_id = daily_last.cost_center_id 
      @daily.account_id = daily_last.account_id 
      @daily.debe = daily_last.debe 
      @daily.haber = daily_last.haber 
      @daily.detalle  = daily_last.detalle
      @daily.por  = daily_last.por
      @daily.tipo  = daily_last.tipo
      @daily.head_daily_id = daily_last.head_daily_id
    end

    respond_modal_with(@daily)
  end

  def edit
    @head_daily = @daily.head_daily
    @tipo = @head_daily.tipo
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
