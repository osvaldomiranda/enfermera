class DireccionsController < ApplicationController
  before_action :set_direccion, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @direccions = Direccion.all
    respond_with(@direccions)
  end

  def show
    respond_with(@direccion)
  end

  def new
    @direccion = Direccion.new
    respond_with(@direccion)
  end

  def edit
  end

  def create
    @direccion = Direccion.new(direccion_params)
    @direccion.save
    respond_with(@direccion)
  end

  def update
    @direccion.update(direccion_params)
    respond_with(@direccion)
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
