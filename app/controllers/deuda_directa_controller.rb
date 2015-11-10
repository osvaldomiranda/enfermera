class DeudaDirectaController < ApplicationController
  before_action :set_deuda_directum, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @deuda_directa = DeudaDirectum.all
    respond_with(@deuda_directa)
  end

  def show
    respond_with(@deuda_directum)
  end

  def new
    @deuda_directum = DeudaDirectum.new
    respond_modal_with(@deuda_directum)
  end

  def edit
    respond_modal_with(@deuda_directum)
  end

  def create
    @deuda_directum = DeudaDirectum.new(deuda_directum_params)
    @deuda_directum.save
    respond_with(@deuda_directum)
  end

  def update
    @deuda_directum.update(deuda_directum_params)
    @person = Person.find(@deuda_directum.person_id)
    render "/dashboard/index"
  end

  def destroy
    @deuda_directum.destroy
    respond_with(@deuda_directum)
  end

  private
    def set_deuda_directum
      @deuda_directum = DeudaDirectum.find(params[:id])
    end

    def deuda_directum_params
      params.require(:deuda_directum).permit(:tipo, :institucion, :cupo_aprobado, :deuda_vigente, :pago_mensual, :vencimineto, :person_id)
    end
end
