class InscriptionsController < ApplicationController
  before_action :set_inscription, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @inscriptions = Inscription.all
    respond_with(@inscriptions)
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

    @inscription = Inscription.new(inscription_params)
    
    if @inscription.save
      
      url = ""
      certificado_html = ""

      user = User.new
      user.email = params[:inscription][:email]
      user.password = params[:inscription][:password]
      user.password_confirmation = params[:inscription][:password_confirmation]
      user.roles_mask = 3
      user.save

      @person = Person.new
      @person.email = params[:inscription][:email]
      @person.rut = params[:inscription][:rut]
      @person.nombres = params[:inscription][:nombres]
      @person.apellido_paterno = params[:inscription][:apellido_paterno]
      @person.apellido_materno = params[:inscription][:apellido_materno]
      @person.nro_registro = params[:inscription][:nro_registro]
      @person.sexo = params[:inscription][:sexo]
      @person.nacionalidad = params[:inscription][:nacionalidad]
      @person.fecha_inscripcion = params[:inscription][:fecha_inscripcion] 
      @person.direccion = params[:inscription][:direccion]
      @person.ciudad = params[:inscription][:ciudad]
      @person.universidad = params[:inscription][:universidad]
      @person.fecha_titulo = params[:inscription][:fecha_titulo]
      @person.tipo_contrato = params[:inscription][:tipo_contrato]
      @person.workplace_id = params[:inscription][:workplace_id]
      @person.url = url
      @person.certificado_html = certificado_html
      @person.save

      Inscription.BuscarCertificado(params[:inscription][:rut])

      @persondocuments = Persondocument.all

      sign_in(user.email)
      render  dashboard_index_path
      
    else  
      redirect_to "/"
    end
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
      @inscription = Inscription.find(params[:id])
    end

    def inscription_params
      params.require(:inscription).permit(:nro_registro, :rut, :nombres, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :tipo_contrato, :estado, :fecha_solicitud, :workplace_id, :forma_pago)
    end
end
