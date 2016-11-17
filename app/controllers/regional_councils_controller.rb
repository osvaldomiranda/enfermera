class RegionalCouncilsController < ApplicationController
  before_action :set_regional_council, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @regional_councils = RegionalCouncil.order(:office_id)
    respond_with(@regional_councils)
  end

  def show
    respond_with(@regional_council)
  end

  def new
    @regional_council = RegionalCouncil.new
    respond_with(@regional_council)
  end

  def edit
  end

  def create
    @regional_council = RegionalCouncil.new(regional_council_params)
    @regional_council.save
    respond_with(@regional_council)
  end

  def update
    @regional_council.update(regional_council_params)
    respond_with(@regional_council)
  end

  def destroy
    @regional_council.destroy
    respond_with(@regional_council)
  end

  private
    def set_regional_council
      @regional_council = RegionalCouncil.find(params[:id])
    end

    def regional_council_params
      params.require(:regional_council).permit(:nombre, :cargo, :email, :fono, :office_id, :person_id)
    end
end
