class PersondocumentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_persondocument, only: [:show, :edit, :update, :destroy, :senddocument]

  respond_to :html

  def index
    @person_id = params[:person_id] 
    @persondocuments = @person_id.present? ? Persondocument.where(person_id: @person_id) : Persondocument.all
    respond_with(@persondocuments)
  end

  def show
    respond_with(@persondocument)
  end

  def new
    @persondocument = Persondocument.new
    @person_id = params[:person_id]
    respond_modal_with(@persondocument)
  end

  def edit
  end

  def create
    @persondocument = Persondocument.new(persondocument_params)
    @persondocument.save

    @person_id = persondocument_params[:person_id] 
    @persondocuments = @person_id.present? ? Persondocument.where(person_id: @person_id) : Persondocument.all
    @person = @person_id.present? ? Person.find(@person_id) : Person.where(rut:current_user.rut).first
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

  def senddocument
    send_file "#{Rails.root}/public#{@persondocument.documento_url}"
  end

  private
    def set_persondocument
      @persondocument = Persondocument.find(params[:id])
    end

    def persondocument_params
      params.require(:persondocument).permit(:nombre, :tipo, :documento, :person_id)
    end
end
