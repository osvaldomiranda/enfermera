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

    @head_dailies_wp = HeadDaily.where(workplace_id: @person.workplace_id).where(id: Daily.select(:head_daily_id).where(account_id: Account.where(codigo:'2040105'))) 
  end

end
