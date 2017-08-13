class WpemailsController < ApplicationController
  before_action :set_wpemail, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workplace_id = params[:workplace_id] || nil

    @wpemails = Wpemail.all.workplace(@workplace_id)
    respond_with(@wpemails)
  end

  def show
    respond_with(@wpemail)
  end

  def new
    @workplace_id = params[:workplace_id] || nil
    @wpemail = Wpemail.new
    respond_with(@wpemail)
  end

  def edit
    @workplace_id = @wpemail.workplace.id
  end

  def create
    @wpemail = Wpemail.new(wpemail_params)
    @wpemail.save
    respond_with(@wpemail)
  end

  def update
    @wpemail.update(wpemail_params)
    respond_with(@wpemail)
  end

  def destroy
    @wpemail.destroy
    respond_with(@wpemail)
  end

  private
    def set_wpemail
      @wpemail = Wpemail.find(params[:id])
    end

    def wpemail_params
      params.require(:wpemail).permit(:email, :workplace_id)
    end
end
