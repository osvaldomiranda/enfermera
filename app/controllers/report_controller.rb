class ReportController < ApplicationController
  def export
    @person = Person.all
    respond_to do |format|
      format.html
      format.xls 
    end
  end
end
