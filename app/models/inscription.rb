class Inscription < ActiveRecord::Base

	include ActiveModel::Validations
  validate :create_person_user

  auto_increment :nro_registro

	GENDERS = ['Masculino', 'Femenino']

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
  validates :nombres, presence: true
  validates :tipo_contrato, presence: true
  validates :sexo, presence: true
  validates :nacionalidad, presence: true
  validates :workplace_id, presence: true
  validates :forma_pago, presence: true

  # Validamos que el telefono solo sea numerico
  #validates :telefono, presence: true #numericality: { only_integer: true }

    # Validamos que el celular solo sea numerico
  #validates :celular, presence: true #numericality: { only_integer: true }


  def self.BuscarCertificado(rut)
    require 'nokogiri'
    require 'rest-client'
    
    numero_rut, digito = rut.split("-")

    puts numero_rut

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

      p=Person.find_by_rut(rut)
      p.url = url
      p.certificado_html = response
      p.estado = "OK"
      
      p.save

    else

      p=Person.find_by_rut(rut)
      p.estado = "PENDIENTE"

      p.save
    
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
      @person.url = ''
      @person.certificado_html = ''
      if  @person.save

      else
        errors.add(:rut, 'No se pudo crear Colegiada')
      end  
      Inscription.BuscarCertificado(self.rut)
    else
      errors.add(:rut, 'No se pudo crear Colegiada')  
    end
  end
end 

	