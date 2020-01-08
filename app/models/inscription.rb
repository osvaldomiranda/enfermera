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
  validates :universidad, presence: true
  validates :fecha_titulo, presence: true
  validates_length_of :password, :minimum => 8

  

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


def self.certificado(rut)
    require 'nokogiri'
    require 'rest-client'
      numero_rut = rut
      begin

        url = "http://webhosting.superdesalud.gob.cl/bases/prestadoresindividuales.nsf/%28searchAll2%29/Search?SearchView&Query=%28FIELD%20rut_pres=#{numero_rut}%29&Start=1&count=10"

        response = Nokogiri::HTML(RestClient.get url)

#  ruts.map{|r| [r,Inscription.certificado(r)]}       

# ['25266796',  '16264057', '13114590', '16260160', '14610547', '17408723', '13977160', '13915560', '17411504', '16751681', '16417677', '19098479', '18316929', '19025618', '19071981', '18396114'] 
# ['18684808', '17958449', '15596373', '16156258', '17716018', '16671582', '18312840', '18766471', '18235492', '13989808', '16540932', '25075349', '18942508', '16927326', '17403438', '18526499'] 
# ['15671642', '18177125', '17611289', '18719291', '15598849', '17503849', '18262240', '17598397', '13561506', '18712777', '15844023', '17532963', '17748246', '17823203', '17641040', '17263417']
# ['16996355', '15678546', '15547288', '17405326', '17314413', '18773050', '17517655', '15761822', '16803518', '17247007', '17217198', '18840666', '17759025', '19088869', '15091553', '11749944'] 
# ['15398450', '18480134', '17729758', '19016979', '17693269', '18860619', '17073584', '18083501', '18318043', '16405696', '15678772', '18329485', '17778685', '16222903', '17350806', '17107952'] 
# ['16494972', '18738565', '17555600', '17860362', '13996007', '16870884', '18132223', '14080702', '13543635', '18825248', '16805169', '20273385', '17778457', '18721424', '16295449', '18467230'] 
# ['17337452', '17937557', '17752219', '14374178', '17999210', '5714580',  '17208015', '17811032', '14030498', '24174572', '17038643', '9103429',  '18936557', '18252274', '17343316', '19090881'] 
# ['17823502', '15827980', '17281982', '18943579', '17693960', '17776967', '17835478', '17843846', '18187838', '16839220', '13266325', '17496199', '17155721', '15825550', '16395483', '16444550'] 
# ['18808363', '17916226', '18373766', '19205794', '17831488', '16977895', '18655282', '15973405', '16836070', '12312312', '18637507', '18721360', '17417443', '18726988', '25102996', '16770874'] 
# ['13612079', '17115374', '14041247', '18229566', '16950785', '15718566']

        # puts response
        # puts ' '
        # puts '----****----'
        # puts ' '
        # puts response.css('td')[0].text

        # puts '***' + response.css('td')[0].text + '***'

      rescue
      end

      unless response.css('td')[0].nil?

        sTexto1 = response.css("a").first.attr('href').split("/").last

        idEnfermera, sTexto2 = sTexto1.split("?") 

        url = "http://webhosting.superdesalud.gob.cl/bases/prestadoresindividuales.nsf/CertificadoRegistro?openform&pid=#{idEnfermera}"


        
        puts "#{rut} ; #{response.css('td')[0].text} ; http://webhosting.superdesalud.gob.cl/bases/prestadoresindividuales.nsf/CertificadoRegistro?openform&pid=#{idEnfermera}"

        response = RestClient.get(url)
        return url
      end 
  end





  def create_person_user
    email = self.email.present? ? self.email : "#{self.rut}sin@email.cl"
    password = self.password.present? ? self.password.length>=8 ? self.password : self.rut : self.rut
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

	