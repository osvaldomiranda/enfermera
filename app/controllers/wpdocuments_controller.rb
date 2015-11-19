class WpdocumentsController < ApplicationController
  before_action :set_wpdocument, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @wpdocuments = Wpdocument.all
    respond_with(@wpdocuments)
  end

  def show
    respond_with(@wpdocument)
  end

  def new
    @wpdocument = Wpdocument.new
    respond_with(@wpdocument)
  end

  def edit
  end

  def create
    @wpdocument = Wpdocument.new(wpdocument_params)
    @wpdocument.save
    respond_with(@wpdocument)
  end

  def update
    @wpdocument.update(wpdocument_params)
    respond_with(@wpdocument)
  end

  def destroy
    @wpdocument.destroy
    respond_with(@wpdocument)
  end

  private
    def set_wpdocument
      @wpdocument = Wpdocument.find(params[:id])
    end

    def wpdocument_params
      params.require(:wpdocument).permit(:nombre, :tipo, :documento, :workplace_id)
    end
end
