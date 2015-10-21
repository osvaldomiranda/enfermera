class SummaryController < ApplicationController
  
  def index
    @person  = Person.find_by_email(current_user.email)
    @spouse = @person.spouse
    @direccions = @person.direccions
    @vehiculos = @person.vehiculos
    @ingreso = @person.ingreso
    @sociedads = @person.sociedads
    @bienes_raices = @person.bienes_raices
    @deuda_directum = @person.deuda_directum
    @deuda_indirectum = @person.deuda_indirectum
    @attachments = @person.documents

 
    @employment_statuses = nil
   
    @dependents = @person.dependent
    @independents = @person.independent
    @jubilados = @person.jubilado
    @universitarios = @person.universitario


  end


  def show
    
    @person  = Person.find_by_email(current_user.email)
    @spouse = @person.spouse
    @direccions = @person.direccions
    @vehiculos = @person.vehiculos
    @ingreso = @person.ingreso
    @sociedads = @person.sociedads
    @bienes_raices = @person.bienes_raices
    @deuda_directum = @person.deuda_directum
    @deuda_indirectum = @person.deuda_indirectum
    @attachments = @person.documents

 
    @employment_statuses = nil
   
    @dependents = @person.dependent
    @independents = @person.independent
    @jubilados = @person.jubilado
    @universitarios = @person.universitario

    render 'index' 

  end  


  def pdf_me
    p = Person.find_by_id(params[:id])
    p.summary_to_pdf(p.email)

    send_file "#{Rails.root}/tmp/#{p.email}.pdf"
  end 

  def csv_me
    p = Person.find_by_id(params[:id])
    p.summary_to_csv(p.email,'csv')

    send_file "#{Rails.root}/tmp/#{p.email}.csv"
  end 


end
