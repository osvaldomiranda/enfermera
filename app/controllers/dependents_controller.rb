class DependentsController < ApplicationController
  before_action :set_dependent, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @dependents = Dependent.where(email: current_user.email)
    respond_with(@dependents)
  end

  def show
    respond_with(@dependent)
  end

  def new
    @dependent = Dependent.new
    respond_with(@dependent)
  end

  def edit
    respond_modal_with(@dependent)
  end

  def create
    @dependent = Dependent.new(dependent_params)
    @dependent.save
  end

  def update
    @dependent.update(dependent_params)
    @person = Person.find(@dependent.person_id)
    render "/dashboard/index"
  end

  def destroy
    @dependent.destroy
    respond_with(@dependent)
  end

  private
    def set_dependent
      @dependent = Dependent.find(params[:id])
    end

    def dependent_params
      params.require(:dependent).permit(:empleador, :rut_empleador, :giro_empresa, :direccion_empresa, :tipo_contrato, :cargo, :fecha_ingreso, :fecha_ingreso_anterior, :fecha_termino_anterior, :person_id)
    end
end
