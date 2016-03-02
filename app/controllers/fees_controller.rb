class FeesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @fees = Fee.all
    respond_with(@fees)
  end

  def show
    respond_with(@fee)
  end

  def new
    @fee = Fee.new
    respond_with(@fee)
  end

  def edit
  end

  def create
    @fee = Fee.new(fee_params)
    @fee.save
    respond_with(@fee)
  end

  def update
    @fee.update(fee_params)
    respond_with(@fee)
  end

  def destroy
    @fee.destroy
    respond_with(@fee)
  end

  private
    def set_fee
      @fee = Fee.find(params[:id])
    end

    def fee_params
      params.require(:fee).permit(:rut, :email, :fecha_pago, :mes, :monto, :person_id)
    end
end
