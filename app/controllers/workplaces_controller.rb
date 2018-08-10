class WorkplacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_workplace, only: [:show, :edit, :update, :destroy, :incomes]

  respond_to :html

  def index
    
    @regional = params[:regional] || nil
    if params["/workplaces"].present?
      @cod_wp = params["/workplaces"][:cod_wp] || nil
    end  
    
    if @regional.present?
      @workplaces = Workplace.where(office_id: @regional).with_codwp(@cod_wp).order(nombre: :asc).page(params[:page]).per_page(20)  
    else
      if current_user.role?(:national_admin) 
        @workplaces = Workplace.all.with_codwp(@cod_wp).order(nombre: :asc).page(params[:page]).per_page(20)
      else
        @workplaces = Workplace.where(office_id: current_user.office.id).with_codwp(@cod_wp).order(nombre: :asc).page(params[:page]).per_page(20)
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
    @Currentfee = params[:valorcuota].to_i
    @income = Income.new
    respond_modal_with(@income)
  end

  def topasive
    person = Person.find(params[:person_id])
    @workplace = person.workplace
    person.to_pasive
    @Currentfee = params[:valorcuota].to_i
    @income = Income.new
    render 'payregister'
  end

  def todeceased
    person = Person.find(params[:person_id])
    @workplace = person.workplace
    person.to_deceased
    @Currentfee = params[:valorcuota].to_i
    @income = Income.new
    render 'payregister'
  end

  def pay

    # TODO: Evitar doble registro de pago, respecto al mes que se está pagando
    # TODO: Evitar el doble registro de pago en caso de que la colegiada 
    #       haya realizado un pago directo y ademas se le descontó por planilla

    puts "***************"
    puts params[:income][:mes_cuota]
    puts "***************"

    msgs = []

    params[:person_ids].each do |id|
      person = Person.find(id)
      fee = person.fees.where(mes_cuota: params[:income][:mes_cuota]).first
      if fee.present?
        msgs << "Ya existe cuota registrada para #{person.nro_registro} #{person.fullname}, #{params[:income][:mes_cuota]} "
      end
    end

    if msgs.count != 0
      redirect_to error_pay_workplace_path(msgs: msgs)  
    else 
      if params[:income][:fecha_pago] == '' || params[:income][:fecha_contable] ==''
        fecha_pago = DateTime.now.strftime("%d-%m-%Y")
        fecha_contable = DateTime.now.strftime("%d-%m-%Y")
      else  
        fecha_pago     = params[:income][:fecha_pago]
        fecha_contable = params[:income][:fecha_contable]
      end
      
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

        @income.fecha_pago  =  Date.parse(fecha_pago)
        @income.fecha_contable  = Date.parse( fecha_contable)
        @income.mes_cuota   = params[:income][:mes_cuota]


        @income.estado      = "CONFIRMADO"
        if @income.save
          valorcuota = params[:income][:valorcuota]
          params[:person_ids].each do |id|
            person = Person.find(id)
            fee = Fee.new
            fee.rut = person.rut
            fee.email = person.email
            

            fee.fecha_pago = Date.parse(fecha_pago)

            fee.mes = params[:income][:mes_cuota]
            fee.monto = valorcuota
            fee.person_id = person.id
            fee.pagador = "Descuento Planilla"
            fee.mes_cuota =  params[:income][:mes_cuota]
            fee.estado = "Confirmado"
            fee.income_id = @income.id
            fee.save
          end
        end
      end  
      render "/adminworckplace/index"
    end
  end

  def error_pay
    @msgs = params[:msgs] 
  end 

  def change_person
    person = Person.find(params[:person_id])
  end

  def create_txt_public_wp
    w = Workplace.first
    w.create_file
  end


  private
    def set_workplace
      @workplace = Workplace.find(params[:id])
    end

    def workplace_params
      params.require(:workplace).permit(:nombre, :ciudad, :region,  :codigo, :telefono, :email, :calle, :numero, :office_id, :cod_wp)
    end
end
