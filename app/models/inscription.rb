class Inscription < ActiveRecord::Base
	include ActiveModel::Validations

  belongs_to :user
  belongs_to :workplace

  after_create :buscar_certificado

	GENDERS = ['Masculino', 'Femenino']
  ESTADOS = {'SOLICITADA' => 'SOLICITADA' , 'RECHAZADA' => 'RECHAZADA', 'APROBADA' => 'APROBADA', 'RUT YA EXISTE' => 'RUT YA EXISTE' }

	def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  NACIONALIDAD      = ['Chilena', 'Extranjero']
  def self.nacionalidad_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    NACIONALIDAD.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  TIPOCONTRATO      = ['Planta', 'Plazo fijo', 'Honorarios']
  def self.tipocontrato_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOCONTRATO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  #Validamos en una expresion regular nuestro email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true #format: { :with => VALID_EMAIL_REGEX , message: "El formato del correo es invalido" }

  # Validamos que el email sea unico
  #validates :email, uniqueness: {case_sensitive: false ,message: "email se encuentra registrado"}

	#validates_with RutFormatValidator, field: [:rut]
  validates :rut, presence: true, rutFormat: true
  validates :apellido_paterno, presence: true
  validates :apellido_materno, presence: true
  validates :nombres, presence: true
  validates :tipo_contrato, presence: true
  validates :sexo, presence: true
  validates :nacionalidad, presence: true
  validates :workplace_id, presence: true
  validates :forma_pago, presence: true
  validates :direccion, presence: true
  validates :ciudad, presence: true
  validates :celular, presence: true
  validates :email, presence: true
  

  # Validamos que el telefono solo sea numerico
  #validates :telefono, presence: true #numericality: { only_integer: true }

    # Validamos que el celular solo sea numerico
  #validates :celular, presence: true #numericality: { only_integer: true }

  scope :with_estado, ->with_estado { where('estado=?', with_estado) if with_estado.present? }
  scope :workplace, -> workplace { where('workplace_id = ?', workplace) if workplace.present?}
  scope :office, -> office { where(workplace_id: Office.find(office).workplaces.pluck(:id)) if office.present?}
  scope :with_paterno, -> with_paterno { where('lower(apellido_paterno) = ?', with_paterno.downcase  ) if with_paterno.present?}
  scope :with_materno, -> with_materno { where('lower(apellido_materno) = ?', with_materno.downcase) if with_materno.present?}
  scope :with_rut, -> with_rut { where(rut: with_rut) if with_rut.present?}

  def buscar_certificado
    require 'nokogiri'
    require 'rest-client'
    
    person = Person.find_by_rut(self.rut)

    if person.present?
      self.estado = "RUT YA EXISTE"
      self.save
    else
      numero_rut, digito = self.rut.split("-")
      begin

        url = "http://webhosting.superdesalud.gob.cl/bases/prestadoresindividuales.nsf/%28searchAll2%29/Search?SearchView&Query=%28FIELD%20rut_pres=#{numero_rut}%29&Start=1&count=10"

        response = Nokogiri::HTML(RestClient.get url)

        
        puts response
        puts ' '
        puts '----****----'
        puts ' '
        #puts response.css('td')[0].text

        #puts '***' + response.css('td')[0].text + '***'

      rescue
      end

      unless response.css('td')[0].nil?


        sTexto1 = response.css("a").first.attr('href').split("/").last

        idEnfermera, sTexto2 = sTexto1.split("?") 

        url = "http://webhosting.superdesalud.gob.cl/bases/prestadoresindividuales.nsf/CertificadoRegistro?openform&pid=#{idEnfermera}"

        response = RestClient.get(url)

        puts ' '
        puts '----****----'
        puts ' '

        puts response

       
        self.url = url
        self.certificado_html = response
        self.estado = "SOLICITADA"
        self.save
      else
        self.estado = "RECHAZADA"
        self.save
      end 
      send_email()
    end  
  end


  def create_person_user
    email = self.email.present? ? self.email : "#{self.rut}sin@email.cl"
    password = self.password.present? ? self.password : self.rut
    user = User.new
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.roles_mask = 3
    user.rut = self.rut
    if user.save
      @person = Person.new
      @person.email = email
      @person.rut = self.rut
      @person.nombres = self.nombres
      @person.apellido_paterno = self.apellido_paterno
      @person.apellido_materno = self.apellido_materno
      @person.sexo = self.sexo
      @person.nacionalidad = self.nacionalidad
      @person.fecha_inscripcion = DateTime.now
      @person.direccion = self.direccion
      @person.ciudad = self.ciudad
      @person.universidad = self.universidad
      @person.fecha_titulo = self.fecha_titulo
      @person.tipo_contrato = self.tipo_contrato
      @person.workplace_id = self.workplace_id
      @person.telefono = self.telefono
      @person.celular = self.celular
      @person.origen = self.origen
      @person.forma_pago = self.forma_pago
      @person.url = self.url
      @person.estado = 'OK'
      @person.certificado_html = self.certificado_html
      @person.save
    end  
  end  

  def fullname
    "#{self.nombres} #{self.apellido_paterno} #{self.apellido_materno}"
  end

  def send_email
    PersonMailer.send_user(self.rut).deliver
  end
end 

	