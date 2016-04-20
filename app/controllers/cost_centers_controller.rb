class CostCentersController < ApplicationController
  before_action :set_cost_center, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cost_centers = CostCenter.all
    respond_with(@cost_centers)
  end

  def show
    respond_with(@cost_center)
  end

  def new
    @cost_center = CostCenter.new
    respond_with(@cost_center)
  end

  def edit
  end

  def create
    @cost_center = CostCenter.new(cost_center_params)
    @cost_center.save
    respond_with(@cost_center)
  end

  def update
    @cost_center.update(cost_center_params)
    respond_with(@cost_center)
  end

  def destroy
    @cost_center.destroy
    respond_with(@cost_center)
  end

  private
    def set_cost_center
      @cost_center = CostCenter.find(params[:id])
    end

    def cost_center_params
      params.require(:cost_center).permit(:codigo, :nombre)
    end
end
