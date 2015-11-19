class PersondocumentsController < ApplicationController
  before_action :set_persondocument, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @persondocuments = Persondocument.all
    respond_with(@persondocuments)
  end

  def show
    respond_with(@persondocument)
  end

  def new
    @persondocument = Persondocument.new
    respond_with(@persondocument)
  end

  def edit
  end

  def create
    @persondocument = Persondocument.new(persondocument_params)
    @persondocument.save
    respond_with(@persondocument)
  end

  def update
    @persondocument.update(persondocument_params)
    respond_with(@persondocument)
  end

  def destroy
    @persondocument.destroy
    respond_with(@persondocument)
  end

  private
    def set_persondocument
      @persondocument = Persondocument.find(params[:id])
    end

    def persondocument_params
      params.require(:persondocument).permit(:nombre, :tipo, :documento, :person_id)
    end
end
