class HeadDailiesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_head_daily, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @head_dailies = HeadDaily.all.order(numero: :desc)
    respond_with(@head_dailies)
  end

  def show
    respond_with(@head_daily)
  end

  def new
    @head_daily = HeadDaily.new
    respond_with(@head_daily)
  end

  def edit
  end

  def create
    @head_daily = HeadDaily.new(head_daily_params)
    @head_daily.save
    respond_with(@head_daily)
  end

  def update
    @head_daily.update(head_daily_params)
    respond_with(@head_daily)
  end

  def destroy
    @head_daily.destroy
    respond_with(@head_daily)
  end

  private
    def set_head_daily
      @head_daily = HeadDaily.find(params[:id])
    end

    def head_daily_params
      params.require(:head_daily).permit(:numero, :user_id, :tipo)
    end
end
