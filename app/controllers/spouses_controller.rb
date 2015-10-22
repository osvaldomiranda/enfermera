class SpousesController < ApplicationController
  before_action :set_spouse, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @spouses = Spouse.all
    respond_with(@spouses)
  end

  def show
    respond_with(@spouse)
  end

  def new
    @spouse = Spouse.new
    respond_modal_with(@spouse)
  end

  def edit
    respond_modal_with(@spouse)
  end

  def create
    @spouse = Spouse.new(spouse_params)
    @spouse.save
    respond_with(@spouse)
  end

  def update
    @person = Person.find(@spouse.person_id)
    if @spouse.update(spouse_params)
      render "/dashboard/index"
    else
      render "error"
    end    
  end

  def destroy
    @spouse.destroy
    respond_with(@spouse)
  end

  private
    def set_spouse
      @spouse = Spouse.find(params[:id])
    end

    def spouse_params
      params.require(:spouse).permit(:rut, :first_name, :last_name, :gender, :nationality, :economic_activity, :education, :origin_country, :resident_country, :profession, :dependents, :university, :number_of_children, :date_birth, :person_id)
    end
end
