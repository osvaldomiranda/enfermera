class PersondocumentsController < ApplicationController
  before_filter :authenticate_user!
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
    respond_modal_with(@persondocument)
  end

  def edit
  end

  def create
    @persondocument = Persondocument.new(persondocument_params)
    @persondocument.save

    @persondocuments = Persondocument.all

    @person = Person.where(email:current_user.email).first
    render "index"
  end

  def update
    @persondocument.update(persondocument_params)
    respond_with(@persondocument)
  end

  def destroy
    @persondocument.destroy
    respond_with(@persondocument)
  end

  def sendfile
    @document = Persondocument.find(params[:id])
    send_file "#{Rails.root}/public#{@document.documento_url}"
  end

  private
    def set_persondocument
      @persondocument = Persondocument.find(params[:id])
    end

    def persondocument_params
      params.require(:persondocument).permit(:nombre, :tipo, :documento, :person_id)
    end
end
