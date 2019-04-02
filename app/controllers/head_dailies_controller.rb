class HeadDailiesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_head_daily, only: [:show, :edit, :update, :destroy, :eliminar, :confirmar, :guardar]

  respond_to :html

  def index
    HeadDaily.where.not(id: Daily.uniq(:head_daily_id).pluck(:head_daily_id)).destroy_all

    @tipo = params[:tipo] || nil
    @origen = params[:origen] || nil
    @estado = params[:estado] || nil
    

    @page = params[:page] || 1

    if params["/head_dailies"].present?
      @numero = params["/head_dailies"][:numero] || nil
      @por = params["/head_dailies"][:por] || nil
      @medio = params["/head_dailies"][:medio] || nil
      @cheque = params["/head_dailies"][:cheque] || nil

      if params[:page].present?
        @page = params[:page]
      else  
        @page = params["/head_dailies"][:page] || 1
      end  
    end


    @page = nil if @page == ""

    @head_dailies = HeadDaily.with_medio(@medio).with_cheque(@cheque).with_por(@por).with_origen(@origen).with_estado(@estado).with_tipo(@tipo).with_numero(@numero).where(folio_office:nil).order(numero: :desc).page(@page).per_page(20) 
    

    respond_with(@head_dailies)
  end

  def show
    @page = params[:page] || 1
    respond_with(@head_daily)
  end

  def new
    @head_daily = HeadDaily.new
    respond_with(@head_daily)
  end

  def edit
    respond_modal_with(@head_daily)
  end

  def create
    @head_daily = HeadDaily.new(head_daily_params)
    
    if current_user.role?(:admin)
      @head_daily.estado = 'CONFIRMADO'
    else
      @head_daily.estado = 'PENDIENTE'
    end  

    if @head_daily.dailies.sum(:debe) !=  @head_daily.dailies.sum(:haber)
      @head_daily.estado = 'NO CUADRA'
    end         

    @head_daily.user_id = current_user.id
    @head_daily.save
    respond_with(@head_daily)
  end

  def update
    @head_daily.update(head_daily_params)

    if @head_daily.dailies.sum(:debe) !=  @head_daily.dailies.sum(:haber)
      @head_daily.estado = 'NO CUADRA'
      @head_daily.save
    end  
    respond_with(@head_daily)
  end

  def destroy
    @head_daily.destroy
    respond_with(@head_daily)
  end

  def guardar
    if @head_daily.dailies.sum(:debe) !=  @head_daily.dailies.sum(:haber)
      @head_daily.estado = 'NO CUADRA'
      @head_daily.save
    else  
      if current_user.role?(:admin)
        @head_daily.estado = 'CONFIRMADO'
      else
        @head_daily.estado = 'PENDIENTE'
      end  
      @head_daily.save      
    end  
    redirect_to head_dailies_path
  end

  def eliminar
    @head_daily.eliminar

    redirect_to head_dailies_path
  end

  def confirmar
    @head_daily.confirmar

    redirect_to "/head_dailies?page=#{params[:page]}"
  end

  def showtopdf
    @head_daily = HeadDaily.find(params[:id])

    render pdf: "#{@head_daily.tipo}#{@head_daily.numero}",  orientation: 'Portrait'
  end

  private
    def set_head_daily
      @head_daily = HeadDaily.find(params[:id])
    end

    def head_daily_params
      params.require(:head_daily).permit(:numero, :user_id, :tipo, :paguesea, :por, :mediopago, :banco, :recibidode, :numcheque, :documento, :fecha_contable, :rut, :workplace_id, :folio_office)
    end
end
