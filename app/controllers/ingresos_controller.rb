class IngresosController < ApplicationController
  before_action :set_ingreso, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ingresos = Ingreso.all
    respond_with(@ingresos)
  end

  def show
    respond_with(@ingreso)
  end

  def new
    @ingreso = Ingreso.new
    respond_with(@ingreso)
  end

  def edit
    respond_modal_with(@ingreso)
  end

  def create
    @ingreso = Ingreso.new(ingreso_params)
    @ingreso.save
    respond_with(@ingreso)
  end

  def update
    @ingreso.update(ingreso_params)
    @person = Person.find(@ingreso.person_id)
    render "/dashboard/index"
  end

  def destroy
    @ingreso.destroy
    respond_with(@ingreso)
  end

  private
    def set_ingreso
      @ingreso = Ingreso.find(params[:id])
    end

    def ingreso_params
      params.require(:ingreso).permit(:sueldo_fijo_mes, :sueldo_variable_mes, :arriendo, :vtas_anuales, :declaracion_renta, :honorarios_mes, :cta_cte, :banco, :person_id)
    end
end
