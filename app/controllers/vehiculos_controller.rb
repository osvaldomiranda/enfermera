class VehiculosController < ApplicationController
  before_action :set_vehiculo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @vehiculos = Vehiculo.all
    respond_with(@vehiculos)
  end

  def show
    respond_with(@vehiculo)
  end

  def new
    @vehiculo = Vehiculo.new
    respond_with(@vehiculo)
  end

  def edit
  end

  def create
    @vehiculo = Vehiculo.new(vehiculo_params)
    @vehiculo.save
    respond_with(@vehiculo)
  end

  def update
    @vehiculo.update(vehiculo_params)
    respond_with(@vehiculo)
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
