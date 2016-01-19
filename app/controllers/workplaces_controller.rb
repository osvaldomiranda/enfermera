class WorkplacesController < ApplicationController
  before_action :set_workplace, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workplaces = Workplace.all
    respond_with(@workplaces)
  end

  def show
    respond_with(@workplace)
  end

  def new
    @workplace = Workplace.new
    respond_modal_with(@workplace)
  end

  def edit
  end

  def create
    @workplace = Workplace.new(workplace_params)
    @workplace.save
    respond_with(@workplace)
  end

  def update
    @workplace.update(workplace_params)
    respond_modal_with(@workplace)
  end

  def destroy
    @workplace.destroy
    respond_with(@workplace)
  end

  private
    def set_workplace
      @workplace = Workplace.find(params[:id])
    end

    def workplace_params
      params.require(:workplace).permit(:nombre, :ciudad, :region)
    end
end
