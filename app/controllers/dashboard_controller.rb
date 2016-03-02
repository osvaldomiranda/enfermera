class DashboardController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @persondocuments = Persondocument.all
    @person = Person.where(email:current_user.email).first
  end
end
