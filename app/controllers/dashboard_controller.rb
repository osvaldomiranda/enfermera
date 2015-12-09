class DashboardController < ApplicationController
  def index
  	@persondocuments = Persondocument.all
    @person = Person.where(email:current_user.email).first
  end
end
