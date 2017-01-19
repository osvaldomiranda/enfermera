# encoding: utf-8
class Api::V1::PeopleController < ApplicationController
  protect_from_forgery exception: :iscollegiate

  def iscollegiate

    @person = Person.find_by_rut(params[:rut]) if params[:rut].present?
    if @person.present?
      render :json=> {iscollegiate: :true, rut: @person.rut, apellido_paterno: @person.apellido_paterno, apellino_materno: @person.apellido_materno , nombres: @person.nombres  } , :status => :ok
    else
      render :json=> {iscollegiate: :false, rut: '', nombre: '', registro: ''  } , :status => :ok
    end  
  end
end
