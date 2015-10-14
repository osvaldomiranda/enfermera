class BienesRaicesController < ApplicationController
  before_action :set_bienes_raice, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bienes_raices = BienesRaice.all
    respond_with(@bienes_raices)
  end

  def show
    respond_with(@bienes_raice)
  end

  def new
    @bienes_raice = BienesRaice.new
    respond_with(@bienes_raice)
  end

  def edit
  end

  def create
    @bienes_raice = BienesRaice.new(bienes_raice_params)
    @bienes_raice.save
    respond_with(@bienes_raice)
  end

  def update
    @bienes_raice.update(bienes_raice_params)
    respond_with(@bienes_raice)
  end

  def destroy
    @bienes_raice.destroy
    respond_with(@bienes_raice)
  end

  private
    def set_bienes_raice
      @bienes_raice = BienesRaice.find(params[:id])
    end

    def bienes_raice_params
      params.require(:bienes_raice).permit(:tipo, :direccion, :valor_comercial, :rol, :hipoteca_banco, :person_id)
    end
end
