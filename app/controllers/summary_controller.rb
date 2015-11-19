class SummaryController < ApplicationController
  
  def index
    @person  = Person.find_by_email(current_user.email)
  end


  def show
    @person  = Person.find_by_email(current_user.email)
    render 'index' 
  end  


  # def pdf_me
  #   p = Person.find_by_id(params[:id])
  #   p.summary_to_pdf(p.email)

  #   send_file "#{Rails.root}/tmp/#{p.email}.pdf"
  # end 

  # def csv_me
  #   p = Person.find_by_id(params[:id])
  #   p.summary_to_csv(p.email,'csv')

  #   send_file "#{Rails.root}/tmp/#{p.email}.csv"
  # end 


end
