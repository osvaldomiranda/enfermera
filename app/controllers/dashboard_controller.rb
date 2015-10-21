class DashboardController < ApplicationController
  def index
    @person = Person.where(email:current_user.email).first
  end
end
