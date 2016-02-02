class CurrentfeesController < ApplicationController
  before_action :set_currentfee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @currentfees = Currentfee.all
    respond_with(@currentfees)
  end

  def show
    respond_with(@currentfee)
  end

  def new
    @currentfee = Currentfee.new
    respond_with(@currentfee)
  end

  def edit
  end

  def create
    @currentfee = Currentfee.new(currentfee_params)
    @currentfee.save
    respond_with(@currentfee)
  end

  def update
    @currentfee.update(currentfee_params)
    respond_with(@currentfee)
  end

  def destroy
    @currentfee.destroy
    respond_with(@currentfee)
  end

  private
    def set_currentfee
      @currentfee = Currentfee.find(params[:id])
    end

    def currentfee_params
      params.require(:currentfee).permit(:valor)
    end
end
