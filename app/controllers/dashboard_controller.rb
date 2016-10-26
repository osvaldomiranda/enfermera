class DashboardController < ApplicationController
  before_filter :authenticate_user!  
  def index
    person_id = params[:person_id]

    if person_id.present?
      @person = Person.find(person_id)
    else
      user = current_user
      @person = Person.find_by_rut(user.rut)
    end

    @persondocuments = @person.persondocuments
    @head_dailies = HeadDaily.where(rut: @person.rut) 
  end

end
