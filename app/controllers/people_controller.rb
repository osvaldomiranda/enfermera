class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :picture, :terms, :termsToPdf]

  respond_to :html

  def index
    @people = Person.all
    respond_with(@people)
  end

  def show
    respond_with(@person)
  end

  def new
    @person = Person.new
    respond_modal_with(@person)
  end


  def picture
    respond_modal_with(@person)
  end

  def edit
    respond_modal_with(@person)
  end

  def create
    @person = Person.new(person_params)
    @person.save
    respond_with(@person)
  end

  def update
    if !person_params[:picture].present?
      if !person_params[:rut].present?
        if person_params[:terms].present?
          render "error_terms" 
        else   
          render "error"
        end 
      else  
        if @person.update(person_params)
          render "/dashboard/index"
        else
          if person_params[:terms].present?
            render "error_terms" 
          else   
            render "error"
          end  
        end
      end  
    else
      @person.update(person_params)
      render "/dashboard/index"
    end  
  end

  def destroy
    @person.destroy
    respond_with(@person)
  end

  def terms
    respond_modal_with(@person)
  end

  def termsToPdf

    render pdf: "terms", formats: :html, encoding: 'utf8'   # Excluding ".pdf" extension.
  end


  def import
    @people = Person.all
    @msg = Person.import(params[:file]).force_encoding('utf-8')
    respond_to do |format|
      format.html {
        if @msg == " "
          render action: 'index', notice: "Clientes Ok"
        else
          render '/people/error'
        end  
      }
    end   
  end


  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit( :email, :rut, :created_at, :updated_at, :picture, :phone, :terms, :fechaterms, :completeeduc, :nombres, :nro_registro, :apellido_paterno, :apellido_materno, :sexo, :nacionalidad, :fecha_inscripcion, :direccion, :ciudad, :universidad, :fecha_titulo, :lugar_trabajo, :tipo_contrato, :workplase_id )
    end
end
