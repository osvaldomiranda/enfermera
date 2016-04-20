class ReportsController < ApplicationController
  def index
  	@offices = Office.all
  end
end
