class IndependentsController < ApplicationController
  before_action :set_independent, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @independents = Independent.all
    respond_with(@independents)
  end

  def show
    respond_with(@independent)
  end

  def new
    @independent = Independent.new
    respond_with(@independent)
  end

  def edit
  end

  def create
    @independent = Independent.new(independent_params)
    @independent.save
    respond_with(@independent)
  end

  def update
    @independent.update(independent_params)
    respond_with(@independent)
  end

  def destroy
    @independent.destroy
    respond_with(@independent)
  end

  private
    def set_independent
      @independent = Independent.find(params[:id])
    end

    def independent_params
      params.require(:independent).permit(:tipo_rentista, :tipo_actividad, :giro_actividad, :fecha_inicio_rubro, :fecha_inicio_actividad, :nombre_empleador_anterior, :cargo, :antiguedad, :person_id)
    end
end
