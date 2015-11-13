# encoding: utf-8
class Person < ActiveRecord::Base

  require 'csv'
  require 'prawn'
  require 'prawn/table'

  has_one :spouse, dependent: :destroy
  has_one :deuda_directum, dependent: :destroy
  has_one :deuda_indirectum, dependent: :destroy
  has_one :ingreso, dependent: :destroy

  has_one :dependent, dependent: :destroy
  has_one :independent, dependent: :destroy
  has_one :jubilado, dependent: :destroy
  has_one :universitario, dependent: :destroy

  has_many :direccions, dependent: :destroy
  has_many :bienes_raices, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :sociedads, dependent: :destroy
  has_many :vehiculos, dependent: :destroy

  mount_uploader :picture, PictureUploader


  # validates :email, :first_name, :last_name, presence: true
  validates :rut, :rut_format => true

  def fullname
    fullname = "#{self.first_name} #{self.last_name}"
  end

  GENDERS      = ['Masculino', 'Femenino']
  EDUCATION    = ['Primaria','Secundaria','Tecnica', 'Universitaria']
  COMPLETEDUC  = ['Completos', 'Incompletos']
  MARITALSTATUS= ['Soltero','Casado','Separado','Divorciado','Viudo']
  MRITALREGIME = ['Con Separacion de Bienes', 'Sin Separacion de Bienes','Con Participacion en los Ganaciales'] 
  COUNTRY      = ['Chilena'] 
  EMPLOYMENT   = ['Dependiente', 'Independiente', 'Jubilado']

  
  def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  def self.education_options_for_select
    #EDUCATION.to_enum.with_index(0).to_a
    EDUCATION.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.completeduc_options_for_select
    #EDUCATION.to_enum.with_index(0).to_a
    COMPLETEDUC.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.maritalstatus_options_for_select
    #MARITALSTATUS.to_enum.with_index(0).to_a
    MARITALSTATUS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.maritalregime_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    MRITALREGIME.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.country_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    COUNTRY.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.employment_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    EMPLOYMENT.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end

  def self.import(file)
      CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
        rowHash = row.to_hash

        person = Person.new
        person.email = rowHash["email"]
        person.first_name = rowHash["first_name"]
        person.last_name = rowHash["last_name"]
        person.rut = rowHash["rut"]
        person.phone = rowHash["phone"]
       
        if person.save

          user = User.new
          user.email = rowHash["email"]
          user.password = rowHash["password"]
          user.password_confirmation = rowHash["password"]
          user.save

          spouse = Spouse.new
          spouse.person_id = person.id
          spouse.save

          dependent = Dependent.new
          dependent.person_id = person.id
          dependent.save

          ingreso = Ingreso.new
          ingreso.person_id = person.id
          ingreso.save

          deuda_directum = DeudaDirectum.new
          deuda_directum.person_id = person.id
          deuda_directum.save

          deuda_indirectum = DeudaIndirectum.new
          deuda_indirectum.person_id = person.id
          deuda_indirectum.save
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

end
