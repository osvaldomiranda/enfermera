class DireccionsController < ApplicationController
  before_action :set_direccion, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @person = Person.find_by_email(current_user.email)
    @direccions = @person.direccions
    respond_with(@direccions)
  end

  def show
    respond_with(@direccion)
  end

  def new
    @direccion = Direccion.new
    respond_modal_with(@direccion)
  end

  def edit
    respond_modal_with(@direccion)
  end

  def create
    @person = Person.find_by_email(current_user.email)
    @direccion = Direccion.new(direccion_params)
    @direccion.person_id = @person.id
    @direccion.save
    @direccions = @person.direccions
    render "index"
  end

  def update
    @direccion.update(direccion_params)
    @person = Person.find_by_email(current_user.email)
    @direccions = @person.direccions
    render "index"
  end

  def destroy
    @direccion.destroy
    respond_with(@direccion)
  end

  private
    def set_direccion
      @direccion = Direccion.find(params[:id])
    end

    def direccion_params
      params.require(:direccion).permit(:tipo, :calle_num_depto, :comuna, :ciudad, :telefono, :celular, :codigo_postal, :tipo_vivienda, :dividendo_arriendo, :casilla, :num_correo, :ciudad, :person_id)
    end
end
