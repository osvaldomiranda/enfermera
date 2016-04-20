# encoding: utf-8
class Person < ActiveRecord::Base

  require 'csv'
  require 'prawn'
  require 'prawn/table'


  has_many :previousjob, dependent: :destroy
  has_many :persondocument, dependent: :destroy
  has_many :fees, dependent: :destroy


  mount_uploader :picture, PictureUploader


  # validates :email, :first_name, :last_name, presence: true
  validates :rut, :rut_format => true

  def fullname
    fullname = "#{self.nombres} #{self.apellido_paterno} #{self.apellido_materno}"
  end

  GENDERS      = ['Masculino', 'Femenino']
  def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 


  NACIONALIDAD      = ['Chilena', 'Extranjero']
  def self.nacionalidad_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    NACIONALIDAD.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  TIPOCONTRATO      = ['Planta', 'Palzo Fijo', 'Honorarios']
  def self.tipocontrato_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOCONTRATO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  FORMAPAGO  = ['Pago Directo', 'Descuento por planilla']
  def self.formapago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    FORMAPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 


  def self.import(file)
      CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
        rowHash = row.to_hash

        person = Person.new
        person.codigo = rowHash["codigo"] 
        person.email = rowHash["email"]
        person.nombres = rowHash["nombres"]
        person.apellido_paterno = rowHash["apellido_paterno"]
        person.apellido_materno = rowHash["apellido_materno"]
        person.rut = rowHash["rut"]
        person.phone = rowHash["phone"]
        person.sexo = rowHash["sexo"]
        person.direccion = rowHash["direccion"]
        person.ciudad = rowHash["ciudad"]
        person.universidad = rowHash["universidad"]
       
        if person.save
          user = User.new
          user.email = rowHash["email"]
          user.password = rowHash["rut"]
          user.password_confirmation = rowHash["rut"]
          user.roles_mask = 3
          user.save
 
        else
          puts "************************"  
          puts "************************"  
          puts   rowHash
          puts "************************"  
          puts "************************"  
        end  
      end  
  end    




  DIA = ['Lunes', 'Martes','Miercoles','Jueves', 'Vierne', 'Sabado', 'Domingo'] 
  def dia(numdia)
    dia = DIA[numdia-1]
  end

  MES = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  def mes(nummes)
    mes = MES[nummes-1]
  end

  def workplace
    workplace = Workplace.find(self.workplace_id)
  end

end
