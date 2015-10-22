class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :picture]

  respond_to :html

  def index
    @people = Person.all
    respond_with(@people)
  end

  def show
    respond_with(@person)
  end

  def new
    @person = Person.new
    respond_modal_with(@person)
  end


  def picture
    respond_modal_with(@person)
  end

  def edit
    respond_modal_with(@person)
  end

  def create
    @person = Person.new(person_params)
    @person.save
    respond_with(@person)
  end

  def update
    if @person.update(person_params)
      render "/dashboard/index"
    else
      render "error"
    end
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end


  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:email, :rut, :first_name, :last_name, :gender, :nationality, :economic_activity, :education, :origin_country, :resident_country, :profession, :dependents, :university, :number_of_children, :marital_status, :matrimonial_regime, :date_birth, :picture)
    end
end
