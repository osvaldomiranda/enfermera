class WorkplacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_workplace, only: [:show, :edit, :update, :destroy, :incomes]

  respond_to :html

  def index
    @regional = params[:regional] || nil
    
    if @regional.present?
      @workplaces = Workplace.where(office_id: @regional).order(nombre: :asc).page(params[:page]).per_page(20)  
    else
      if current_user.role?(:national_admin) 
        @workplaces = Workplace.all.order(nombre: :asc).page(params[:page]).per_page(20)
      else
        @workplaces = Workplace.where(office_id: current_user.office.id).order(nombre: :asc).page(params[:page]).per_page(20)
      end    
    end
    
    respond_with(@workplaces)
  end

  def show
    @wp_monto_mes = @workplace.fees.order(:mes_cuota).group(:mes_cuota).sum(:monto)
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

  def incomes
    respond_with(@workplace)
  end

  def payregister

    @workplace = Workplace.find(params[:id])
    # @workplace = Workplace.find(1)
    @income = Income.new
    respond_modal_with(@income)
  end

  def pay
    
    if params[:person_ids].present?
      @income = Income.new
      @income.monto       =  params[:income][:monto]
      @income.person_id   =  current_user.id
      @income.office_id   =  params[:income][:office_id]
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
        params[:person_ids].each do |id|
          person = Person.find(id)
          fee = Fee.new
          fee.rut = person.rut
          fee.email = person.email
          fee.fecha_pago = params[:income][:fecha]
          fee.mes = 1
          fee.monto = valorcuota
          fee.person_id = person.id
          fee.pagador = "Descuento Planilla"
          fee.mes_cuota =  params[:income][:tipo]
          fee.estado = "Confirmado"
          fee.income_id = @income.id
          fee.save
        end
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
