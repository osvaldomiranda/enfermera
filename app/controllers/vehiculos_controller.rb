class VehiculosController < ApplicationController
  before_action :set_vehiculo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @person = Person.find_by_email(current_user.email)
    @vehiculos = @person.vehiculos
    respond_with(@vehiculos)
  end

  def show
    respond_with(@vehiculo)
  end

  def new
    @vehiculo = Vehiculo.new
    respond_modal_with(@vehiculo)
  end

  def edit
    respond_modal_with(@vehiculo)
  end

  def create
    @person = Person.find_by_email(current_user.email)
    @vehiculo = Vehiculo.new(vehiculo_params)
    @vehiculo.person_id = @person.id
    @vehiculo.save
    @vehiculos = @person.vehiculos
    render "index"
  end

  def update
    @vehiculo.update(vehiculo_params)
    @person = Person.find_by_email(current_user.email)
    @vehiculos = @person.vehiculos
    render "index"
  end

  def destroy
    @vehiculo.destroy
    respond_with(@vehiculo)
  end

  private
    def set_vehiculo
      @vehiculo = Vehiculo.find(params[:id])
    end

    def vehiculo_params
      params.require(:vehiculo).permit(:tipo, :marca, :modelo, :agno, :patente, :valor_comercia, :prenda_afavor, :person_id)
    end
end
