class SociedadsController < ApplicationController
  before_action :set_sociedad, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @person = Person.find_by_email(current_user.email)
    @sociedads = @person.sociedads
    respond_with(@sociedads)
  end

  def show
    respond_with(@sociedad)
  end

  def new
    @sociedad = Sociedad.new
    respond_modal_with(@sociedad)
  end

  def edit
    respond_modal_with(@sociedad)
  end

  def create
    @person = Person.find_by_email(current_user.email)
    @sociedad = Sociedad.new(sociedad_params)
    @sociedad.person_id = @person.id
    @sociedad.save
    @sociedads = @person.sociedads
    render "index"
  end

  def update
    @sociedad.update(sociedad_params)
    @person = Person.find_by_email(current_user.email)
    @sociedads = @person.sociedads
    render "index"
  end

  def destroy
    @sociedad.destroy
    respond_with(@sociedad)
  end

  private
    def set_sociedad
      @sociedad = Sociedad.find(params[:id])
    end

    def sociedad_params
      params.require(:sociedad).permit(:tipo, :porcentaje, :capital, :nombre, :rut, :person_id)
    end
end
