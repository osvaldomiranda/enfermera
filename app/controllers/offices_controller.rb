class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @offices = Office.all
    respond_with(@offices)
  end

  def show
    respond_with(@office)
  end

  def new
    @office = Office.new
    respond_modal_with(@office)
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    @office.save
    respond_with(@office)
  end

  def update
    @office.update(office_params)
    respond_with(@office)
  end

  def destroy
    @office.destroy
    respond_with(@office)
  end

  private
    def set_office
      @office = Office.find(params[:id])
    end

    def office_params
      params.require(:office).permit(:nombre, :region, :ciudad, :email, :contacto)
    end
end
