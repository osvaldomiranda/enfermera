class NationalCouncilsController < ApplicationController
  before_filter :authenticate_user!, only:[:new, :create, :index,:edit, :update, :destroy]
  before_action :set_national_council, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @national_councils = NationalCouncil.all
    respond_with(@national_councils)
  end

  def show
    respond_with(@national_council)
  end

  def new
    @national_council = NationalCouncil.new
    respond_with(@national_council)
  end

  def edit
  end

  def create
    @national_council = NationalCouncil.new(national_council_params)
    @national_council.save
    respond_with(@national_council)
  end

  def update
    @national_council.update(national_council_params)
    respond_with(@national_council)
  end

  def destroy
    @national_council.destroy
    respond_with(@national_council)
  end

  private
    def set_national_council
      @national_council = NationalCouncil.find(params[:id])
    end

    def national_council_params
      params.require(:national_council).permit(:nombre, :imagen, :cargo, :curriculum, :web)
    end
end
