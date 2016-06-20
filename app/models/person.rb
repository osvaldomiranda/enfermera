# encoding: utf-8
class Person < ActiveRecord::Base

  require 'csv'
  require 'prawn'
  require 'prawn/table'

  belongs_to :workplace


  has_many :previousjob, dependent: :destroy
  has_many :persondocuments, dependent: :destroy
  has_many :fees, dependent: :destroy


  mount_uploader :picture, PictureUploader


  # validates :email, :first_name, :last_name, presence: true
  #validates :rut, :rut_format => true

  scope :active, ->estado { where.not(rut: nil) if estado=='A' }
  scope :workplace, -> workplace { where('workplace_id = ?', workplace) if workplace.present?}


  ESTADOS = { "A" => "Con Rut"
              }

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
      @person = Person.where(nro_registro: rowHash["nro_registro"])
      if ! @person.present?
        person = Person.new
        person.nro_registro = rowHash["nro_registro"] 
        person.rut = rowHash["rut"]        
        person.nombres = rowHash["nombres"]
        person.apellido_paterno = rowHash["apellido_paterno"]
        person.apellido_materno = rowHash["apellido_materno"]
        person.sexo = rowHash["sexo"]
        person.direccion = rowHash["direccion"]
        person.ciudad = rowHash["ciudad"]
        person.universidad = rowHash["universidad"]
        person.fecha_titulo = rowHash["fecha_titulo"]
        if person.save
        else
          puts "************************"  
          puts "************************"  
          puts   rowHash
          puts "************************"  
          puts "************************"  
        end
      end   
    end    
  end    


  def self.import_update(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      
      if rowHash["nro_registro"].present?
        person = Person.where(nro_registro: rowHash["nro_registro"]).first
        if person.present?

          person.lugar_trabajo = rowHash["lugar_trabajo"]    
          if rowHash["rut"].present? 
            if rowHash["rut"] != "N/R-"
              person.rut = rowHash["rut"]
            end
          end  
        end  
      else
        person = Person.where(rut: rowHash["rut"]).first
        if person.present?
          person.lugar_trabajo = rowHash["lugar_trabajo"]
        end
      end 


      if person.present?
        person.save
      else
        puts "************************"  
        puts "************************"  
        puts   rowHash
        puts "************************"  
        puts "************************"  
      end    
    end 
    Person.where.not(lugar_trabajo: nil).map {|p| p.workplace_id=Workplace.find_by_cod_wp(p.lugar_trabajo).id if Workplace.find_by_cod_wp(p.lugar_trabajo).present?; p.save}
  end    


  def self.create_user(file)

      CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
        p = Person.where(rut: rowHash["rut"]).first
        u = User.where(rut: rowHash["rut"]).first
        if !u.present?
          u=User.new
          u.rut=p.rut 
          u.email=p.email.present? ? p.email : "#{p.rut}sin@mail.cl"
          u.password = "#{p.apellido_paterno}#{p.nro_registro}"
          u.password_confirmation = "#{p.apellido_paterno}#{p.nro_registro}"
          u.roles_mask=3 
          u.save
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
