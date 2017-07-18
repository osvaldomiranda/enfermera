class WpdiscountsController < ApplicationController
  before_action :set_wpdiscount, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @wpdiscounts = Wpdiscount.all
    respond_with(@wpdiscounts)
  end

  def show
    respond_with(@wpdiscount)
  end

  def new
    @wpdiscount = Wpdiscount.new
    respond_with(@wpdiscount)
  end

  def edit
  end

  def create
    @wpdiscount = Wpdiscount.new(wpdiscount_params)
    @wpdiscount.save
    respond_with(@wpdiscount)
  end

  def update
    @wpdiscount.update(wpdiscount_params)
    respond_with(@wpdiscount)
  end

  def destroy
    @wpdiscount.destroy
    respond_with(@wpdiscount)
  end

  private
    def set_wpdiscount
      @wpdiscount = Wpdiscount.find(params[:id])
    end

    def wpdiscount_params
      params.require(:wpdiscount).permit(:discountfile, :email, :workplace_id)
    end
end
