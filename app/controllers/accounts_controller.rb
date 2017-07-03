class AccountsController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @accounts = Account.all
    respond_with(@accounts)
  end

  def show
    respond_with(@account)
  end

  def new
    @account = Account.new
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.save

    @accounts = Account.all
    render "index"
  end

  def update
    @account.update(account_params)
    
    @accounts = Account.all
    render "index"
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:codigo, :nombre)
    end
end
