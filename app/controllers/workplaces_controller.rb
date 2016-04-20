class WorkplacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_workplace, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workplaces = Workplace.all
    respond_with(@workplaces)
  end

  def show
    respond_with(@workplace)
  end

  def new
    @workplace = Workplace.new
    respond_modal_with(@workplace)
  end

  def edit
    respond_modal_with(@workplace)
  end

  def create
    @workplace = Workplace.new(workplace_params)
    @workplace.save
    respond_with(@workplace)
  end

  def update
    @workplace.update(workplace_params)
    respond_modal_with(@workplace)
  end

  def destroy
    @workplace.destroy
    respond_with(@workplace)
  end


  def payregister
    @workplace = Workplace.find(params[:income][:workplace_id])
    # @workplace = Workplace.find(1)
    @income = Income.new
    respond_modal_with(@income)
  end

  def pay

    @income = Income.new
    @income.monto       =  params[:income][:monto]
    @income.person_id   =  nil
    @income.workplace_id=  params[:income][:workplace_id]
    @income.tipo        = "Descuento Planilla"
    @income.user_id     =  params[:income][:user_id]
    @income.document    =  params[:income][:document]
    @income.banco       =  params[:income][:banco]
    @income.mediopago   =  params[:income][:mediopago]
    @income.fecha       =  DateTime.now
    @income.estado      = "CONFIRMADO"

    if @income.save

      valorcuota = Currentfee.last.valor
      n = params[:income][:monto].to_i/valorcuota

      @workplace = Workplace.find(params[:income][:workplace_id])
      
      @workplace.people.each do |person|
        fee = Fee.new
        fee.rut = person.rut
        fee.email = person.email
        fee.fecha_pago = params[:income][:fecha]
        fee.mes = 1
        fee.monto = valorcuota
        fee.person_id = person.id
        fee.pagador = "Descuento Planilla"
        fee.mes_cuota =  1
        fee.estado = "Confirmado"
        fee.income_id = @income.id
        fee.save
      end
    end

    render "/adminworckplace/index"
  end


  private
    def set_workplace
      @workplace = Workplace.find(params[:id])
    end

    def workplace_params
      params.require(:workplace).permit(:nombre, :ciudad, :region)
    end
end
