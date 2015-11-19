class PreviousjobsController < ApplicationController
  before_action :set_previousjob, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @previousjobs = Previousjob.all
    respond_with(@previousjobs)
  end

  def show
    respond_with(@previousjob)
  end

  def new
    @previousjob = Previousjob.new
    respond_with(@previousjob)
  end

  def edit
  end

  def create
    @previousjob = Previousjob.new(previousjob_params)
    @previousjob.save
    respond_with(@previousjob)
  end

  def update
    @previousjob.update(previousjob_params)
    respond_with(@previousjob)
  end

  def destroy
    @previousjob.destroy
    respond_with(@previousjob)
  end

  private
    def set_previousjob
      @previousjob = Previousjob.find(params[:id])
    end

    def previousjob_params
      params.require(:previousjob).permit(:establecimiento, :ciudad, :region, :desde, :hasta, :person_id)
    end
end
