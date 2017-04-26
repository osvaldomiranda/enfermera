class InscriptionsController < ApplicationController
  before_filter :authenticate_user! , only: [:index, :edit, :update, :destroy, :change_state]
  before_action :set_inscription, only: [:show, :edit, :update, :destroy, :change_state]

  respond_to :html

  def index
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @inscriptions = Inscription.office(office_id).with_estado(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc).page(params[:page]).per_page(20)  

    respond_with(@inscriptions)
  end

  def change_state
    if params[:change_state].present?
      @inscription.estado = params[:change_state]
      @inscription.user_id = current_user.id
      if @inscription.save
        @inscription.create_person_user
      end
    end

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @inscriptions = Inscription.office(office_id).with_estado(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc).page(params[:page]).per_page(20)  

    render 'inscriptions/index'
  end

  def show
    respond_with(@inscription)
  end

  def new
    @valorcuota = Currentfee.last.valor
    @inscription = Inscription.new
    respond_with(@inscription)
  end

  def edit
  end

  def create
    inscription_params[:email] = "#{inscription_params[:rut]}sin@email.cl" unless inscription_params[:email].present?
    
    @inscription = Inscription.new(inscription_params)
    @inscription.save
    respond_with(@inscription)
  end

  def update
    @inscription.update(inscription_params)
    respond_with(@inscription)
  end

  def destroy
    @inscription.destroy
    respond_with(@inscription)
  end

  private
    def set_inscription
      if params[:id].present?
        @inscription = Inscription.find(params[:id])
      end  
    end

    def inscription_params
      params.require(:inscription).permit(:nro_registro, :rut, :nombres, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :tipo_contrato, :estado, :fecha_solicitud, :workplace_id, :forma_pago, :email, :password, :password_confirmation, :telefono, :celular, :origen, :pais_origen, :change_state)
    end
end
