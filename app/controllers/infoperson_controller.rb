class InfopersonController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def creados

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
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
    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).this_month().order(created_at: :desc).page(params[:page]).per_page(20)  
    respond_with(@people)
  end

  def modificados

    if params["/people"].present?
      @apellido_paterno = params["/people"][:apellido_paterno]
      @apellido_materno = params["/people"][:apellido_materno]
      @rut = params["/people"][:rut] || nil
      @nro_registro = params["/people"][:nro_registro] || nil
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
    @people = Person.office(office_id).member(@member).active(@estado).workplace(@lugar_trabajo).with_paterno(@apellido_paterno).with_materno(@apellido_materno).with_rut(@rut).with_registro(@nro_registro).update_this_month().order(created_at: :desc).page(params[:page]).per_page(20)  
    respond_with(@people)
  end

end
