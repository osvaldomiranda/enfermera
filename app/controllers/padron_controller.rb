class PadronController < ApplicationController
  def index
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @people = Person.padron(@estado).office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc).page(params[:page]).per_page(20)  
  
  end

  def toxls
    require 'csv'

    
    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
    end  
 
    @estado = params[:estado] || nil
    @lugar_trabajo = params[:lugar_trabajo] || nil


    if params[:office].present?
      office_id = Office.where(nombre:params[:office]).first.id 
    else  
      office_id = nil
    end  
    @office = params[:office] || nil
    @member = true

    if (current_user.rol <= 7)
      office_id = current_user.office.id
    end
    @people = Person.padron(@estado).office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).order(created_at: :desc)
  

    respond_to do |format|
      format.xls 
    end
  end

end
