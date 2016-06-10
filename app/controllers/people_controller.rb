class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_person, only: [:show, :edit, :cancel, :update, :destroy, :picture, :terms, :termstopdf, :payregister]

  respond_to :html

  def index
    @estado = params[:estado] || nil
    
    if @estado.present?
      if @estado== 'I'
        @people = Person.inactive.order(created_at: :desc).page(params[:page]).per_page(20)  
      end
      if @estado== 'A'
        @people = Person.active.order(created_at: :desc).page(params[:page]).per_page(20)  
      end
    else
       @people = Person.all.order(created_at: :desc).page(params[:page]).per_page(20)  
    end

    respond_with(@people)
  end

  def show
    respond_with(@person)
  end

  def new
    @person = Person.new
    respond_modal_with(@person)
  end


  def picture
    respond_modal_with(@person)
  end

  def edit
    @valorcuota = Currentfee.last.valor
    respond_modal_with(@person)
  end

  def create
    @person = Person.new(person_params)
    @person.save

    respond_with(@person)
  end

  def cancel
    @person = Person.find(params[:id])
    @person.estado = "CANCELADO"
    @person.save
    respond_with(@person)
  end
  
  def update

    @persondocuments = Persondocument.all

    if !person_params[:picture].present?
      if !person_params[:rut].present?
        if person_params[:terms].present?
          @person.terms = "OK"
          @person.fechaterms = DateTime.now
          @person.save
          redirect_to dashboard_index_path
        else   
          render "error"
        end 
      else  
        if @person.update(person_params)
          redirect_to dashboard_index_path
        else
          if person_params[:terms].present?
            @person.terms = "OK"
            @person.fechaterms = DateTime.now
            @person.save
            redirect_to dashboard_index_path
          else   
            render "error"
          end  
        end
      end  
    else
      @person.update(person_params)
      redirect_to dashboard_index_path
    end  
 
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end

  def terms
    @person = Person.find(params[:id])
    respond_modal_with(@person)
  end

  def termstopdf
    @person = Person.find(params[:id])
    puts "****************"
    puts @person
    puts params[:id]
    puts "****************"

    render pdf: "terms", formats: :html, encoding: 'utf8'   # Excluding ".pdf" extension.
  end


  def import

    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def import_update
    puts "*****************"
    puts params
    puts "*****************"
    @people = Person.all
    @msg = Person.import_update(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Colegiadas Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end

  def payregister
    @income = Income.new
    respond_modal_with(@income)
  end

  def pay

    @income = Income.new
    @income.monto       =  params[:income][:monto]
    @income.person_id   =  params[:income][:person_id]
    @income.workplace_id=  params[:income][:workplace_id]
    @income.tipo        = "Colegiada"
    @income.user_id     =  params[:income][:user_id]
    @income.document    =  params[:income][:document]
    @income.banco       =  params[:income][:banco]
    @income.mediopago   =  params[:income][:mediopago]
    @income.fecha       =  DateTime.now
    @income.estado      = "POR CONFIRMAR"

    if @income.save
      valorcuota = Currentfee.last.valor
      n = params[:income][:monto].to_i/valorcuota
      @person = Person.find(params[:income][:person_id])
      (1..n).each do |i|
        fee = Fee.new
        fee.rut = @person.rut
        fee.email = @person.email
        fee.fecha_pago = params[:income][:fecha]
        fee.mes = i
        fee.monto = valorcuota
        fee.person_id = @person.id
        fee.pagador = "Pago Directo Colegiada"
        fee.mes_cuota =  i
        fee.estado = "Por Confirmar"
        fee.income_id = @income.id
        fee.save
      end
    end

    @persondocuments = Persondocument.all

    redirect_to dashboard_index_path
  end

  def create_user
    Person.create_user
  end


  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit( :email, :rut, :created_at, :updated_at, :picture, :phone, :terms, :fechaterms, :completeeduc, :nombres, :nro_registro, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :lugar_trabajo, :tipo_contrato, :workplase_id, :forma_pago )
    end
    def income_params
      params.require(:income).permit( :fecha, :tipo, :person_id, :workplace_id, :user_id, :monto , :banco, :mediopago, :document )
    end

 
end
