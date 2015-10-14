class SociedadsController < ApplicationController
  before_action :set_sociedad, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sociedads = Sociedad.all
    respond_with(@sociedads)
  end

  def show
    respond_with(@sociedad)
  end

  def new
    @sociedad = Sociedad.new
    respond_with(@sociedad)
  end

  def edit
  end

  def create
    @sociedad = Sociedad.new(sociedad_params)
    @sociedad.save
    respond_with(@sociedad)
  end

  def update
    @sociedad.update(sociedad_params)
    respond_with(@sociedad)
  end

  def destroy
    @sociedad.destroy
    respond_with(@sociedad)
  end

  private
    def set_sociedad
      @sociedad = Sociedad.find(params[:id])
    end

    def sociedad_params
      params.require(:sociedad).permit(:tipo, :porcentaje, :capital, :nombre, :rut, :person_id)
    end
end
