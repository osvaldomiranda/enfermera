class ScientificSocietiesController < ApplicationController
  before_filter :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :set_scientific_society, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @scientific_societies = ScientificSociety.order('id DESC')
    respond_with(@scientific_societies)
  end

  def show
    respond_with(@scientific_society)
  end

  def new
    @scientific_society = ScientificSociety.new
    respond_with(@scientific_society)
  end

  def edit
  end

  def create
    @scientific_society = ScientificSociety.new(scientific_society_params)
    @scientific_society.save
    respond_with(@scientific_society)
  end

  def update
    @scientific_society.update(scientific_society_params)
    respond_with(@scientific_society)
  end

  def destroy
    @scientific_society.destroy
    respond_with(@scientific_society)
  end

  private
    def set_scientific_society
      @scientific_society = ScientificSociety.find(params[:id])
    end

    def scientific_society_params
      params.require(:scientific_society).permit(:nombre, :descripcion, :logo, :direccion, :telefono, :contacto, :web_url)
    end
end
