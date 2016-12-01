class BenefitsController < ApplicationController
  before_action :set_benefit, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @benefits = Benefit.where(office_id: nil)
    @offices = Office.all
    respond_with(@benefits)
  end

  def show
    respond_with(@benefit)
  end

  def new
    @benefit = Benefit.new
    respond_with(@benefit)
  end

  def edit
  end

  def create
    @benefit = Benefit.new(benefit_params)
    @benefit.save

    @offices = Office.all
    respond_with(@benefit)
  end

  def update
    @benefit.update(benefit_params)
    @offices = Office.all
    respond_with(@benefit)
  end

  def destroy
    @benefit.destroy
    @offices = Office.all
    respond_with(@benefit)
  end

  private
    def set_benefit
      @benefit = Benefit.find(params[:id])
    end

    def benefit_params
      params.require(:benefit).permit(:institucion, :resumen, :imagen, :web, :office_id)
    end
end
