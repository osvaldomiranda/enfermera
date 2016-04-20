class DashboardController < ApplicationController
  before_filter :authenticate_user!  
  def index
  	person_id = params[:person_id]
    @persondocuments = Persondocument.where(person_id: person_id)
    @person = Person.where(id: person_id).first
  end
end
