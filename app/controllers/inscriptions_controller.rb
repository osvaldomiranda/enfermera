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
    @inscription = Inscription.new
    respond_with(@inscription)
  end

  def edit
  end

  def create
    @inscription = Inscription.new(inscription_params)
    @inscription.save
    
    user = User.new
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    user.save

    person = Person.new
    person.email = params[:user][:email]
    person.save

    sign_in(user)

    render "home/index"
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
      params.require(:inscription).permit(:nro_registro, :rut, :nombres, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :tipo_contrato, :estado, :fecha_solicitud)
    end
end
