class UniversitariosController < ApplicationController
  before_action :set_universitario, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @universitarios = Universitario.all
    respond_with(@universitarios)
  end

  def show
    respond_with(@universitario)
  end

  def new
    @universitario = Universitario.new
    respond_with(@universitario)
  end

  def edit
  end

  def create
    @universitario = Universitario.new(universitario_params)
    @universitario.save
    respond_with(@universitario)
  end

  def update
    @universitario.update(universitario_params)
    respond_with(@universitario)
  end

  def destroy
    @universitario.destroy
    respond_with(@universitario)
  end

  private
    def set_universitario
      @universitario = Universitario.find(params[:id])
    end

    def universitario_params
      params.require(:universitario).permit(:email, :universidad, :carrera, :encurso, :renta_familiar, :nombre_padre, :rut_padre, :person_id)
    end
end
