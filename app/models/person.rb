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
  validates :rut, presence: true, :uniqueness => {:scope => :rut}
  validates :rut, :rut_format => true

  def fullname
    fullname = "#{self.first_name} #{self.last_name}"
  end

  GENDERS      = ['Masculino', 'Femenino']
  EDUCATION    = ['Basica','Media','Tecnica', 'Universitaria']
  MARITALSTATUS= ['Soltero','Casado','Separado','Divorciado','Viudo']
  MRITALREGIME = ['Con Separacion de Bienes', 'Sin Separacion de Bienes','Con Participacion en los Ganaciales'] 
  COUNTRY      = ['Chilena'] 


  
  def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  def self.education_options_for_select
    #EDUCATION.to_enum.with_index(0).to_a
    EDUCATION.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
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

  def summary_to_pdf(email)
    @people  = Person.where(email: email)
    p = @people.first
    id = p.id
    @spouses = Spouse.where(person_id: id)
    @direccions = Direccion.where(person_id: id)
    @vehiculos = Vehiculo.where(person_id: id)
    @ingresos = Ingreso.where(person_id: id)
    @sociedads = Sociedad.where(person_id: id)
    @bienes_raices = BienesRaice.where(person_id: id)
    @deuda_directa = DeudaDirectum.where(person_id: id)
    @deuda_indirecta = DeudaIndirectum.where(person_id: id)
    # @employment_statuses = EmploymentStatus.where(email: user.email)
   
    @dependents = Dependent.where(person_id: id)
    @independents = Independent.where(person_id: id)
    @jubilados = Jubilado.where(person_id: id)
    @universitarios = Universitario.where(person_id: id)

    pdf = Prawn::Document.new

    pdf.image "#{Rails.root}/app/assets/images/logo-capitalizarme-top.png"
    pdf.move_down 10
    pdf.text "Estado Situación", size: 20, style: :bold
    pdf.move_down 20
    
    pdf.text "email: #{p.email}"
    pdf.move_down 20
    pdf.text "Datos Personales"
    data = []
    data << ['Rut',
              'Nombres',
              'Apellidos',
              'Genero', 
              'Nacionalidad',
              'Actividad', 
              'Educacion', 
              'Universidad'
              ]

    @people.each do |person| 
    data << [
        "#{ person.rut }", 
        "#{ person.first_name}", 
        "#{ person.last_name }",
        "#{ person.gender  }",
        "#{ person.nationality}", 
        "#{ person.economic_activity}", 
        "#{ person.education }",
        "#{ person.university }"
        
        
         ] 
    end
    pdf.table(data)do
      style row(0), :style => :bold, :size => 8
      style row(1), :size => 8
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
    
    pdf.move_down 10
    data = []
    data << [ 
              'Pais Origen',
              'Pais Residencia',
              'Profesion', 
              'Personas dependientes',
              'N Hijos',
              'Estado Civil',
              'Regimen Matrimonial',
              'Fecha Nacimiento']

    @people.each do |person| 
    data << [
        "#{ person.origin_country }",
        "#{ person.resident_country }",
        "#{ person.profession }",
        "#{ person.dependents   }",
        "#{ person.number_of_children}", 
        "#{ person.marital_status }",
        "#{ person.matrimonial_regime}",
        "#{ person.date_birth }"
         ] 
    end
    pdf.table(data)do
      style row(0), :style => :bold, :size => 8
      style row(1), :size => 8
      self.row_colors = ["DDDDDD","FFFFFF"]
      self.header = true
    end
   
    pdf.move_down 20
    pdf.text "Datos Conyugue"
    data = []
    data << [
        'Rut',
        'Nombres',
        'Apellidos',
        'Genero',
        'Nacionalidad',
        'Actividad',
        'Educacion',
        'Universidad',
        'Pais Origen',
        'Pais Residencia'
      ]

      @spouses.each do |person| 
      data << [
          "#{  person.rut }", 
          "#{  person.first_name }", 
          "#{  person.last_name }", 
          "#{  person.gender }", 
          "#{  person.nationality }", 
          "#{  person.economic_activity }", 
          "#{  person.education }", 
          "#{  person.university }",  
          "#{  person.origin_country }", 
          "#{  person.resident_country }", 
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end

      pdf.move_down 20
      # @employment_statuses.each do |employment_status| 
      
      # case employment_status.name 
      # when 'DEPENDIENTE' 
        pdf.text "Trabajador Dependiente"
        data = [] 
        data << [
     
          'Empleador',
          'Rut empleador',
          'Giro empresa',
          'Direccion empresa',
          'Tipo contrato',
          'Cargo',
          'Fecha ingreso',
          'Fecha ingreso anterior',
          'Fecha termino anterior',
        ]

        @dependents.each do |dependent|
        data << [
     
          "#{  dependent.empleador }", 
          "#{  dependent.rut_empleador }", 
          "#{  dependent.giro_empresa }", 
          "#{  dependent.direccion_empresa }", 
          "#{  dependent.tipo_contrato }", 
          "#{  dependent.cargo }", 
          "#{  dependent.fecha_ingreso }", 
          "#{  dependent.fecha_ingreso_anterior }", 
          "#{  dependent.fecha_termino_anterior }"
        ]
        end 
        pdf.table(data)do
          style row(0), :style => :bold, :size => 8
          style row(1), :size => 8
          self.row_colors = ["DDDDDD","FFFFFF"]
          self.header = true
        end
    
      # when 'INDEPENDIENTE' 
      #   pdf.text "Trabajador Independiente"
      #   data = []
      #   data << [
      #     'Tipo rentista',
      #     'Tipo actividad',
      #     'Giro actividad',
      #     'Fecha inicio rubro',
      #     'Fecha inicio actividad',
      #     'Nombre empleador anterior',
      #     'Cargo',
      #     'Antiguedad'
      #   ]

      #   @independents.each do |independent|
      #   data << [
      #     "#{  independent.tipo_rentista }", 
      #     "#{  independent.tipo_actividad }", 
      #     "#{  independent.giro_actividad }", 
      #     "#{  independent.fecha_inicio_rubro }", 
      #     "#{  independent.fecha_inicio_actividad }", 
      #     "#{  independent.nombre_empleador_anterior }", 
      #     "#{  independent.cargo }", 
      #     "#{  independent.antiguedad }" 
      #   ]
      #   end 
      #   pdf.table(data)do
      #     style row(0), :style => :bold, :size => 8
      #     style row(1), :size => 8
      #     self.row_colors = ["DDDDDD","FFFFFF"]
      #     self.header = true
      #   end


      # when 'JUBILADO'  

      #   pdf.text "Jubilado"
      #   data = []
      #   data << [
      #     'Ultimo empleador',
      #     'Institucion pagadora',
      #     'Afp',
      #     'Cia seguro'
      #   ]

      #   @jubilados.each do |jubilado| 
      #   data<< [
     
      #     "#{  jubilado.ultimo_empleador }", 
      #     "#{  jubilado.institucion_pagadora }", 
      #     "#{  jubilado.afp }", 
      #     "#{  jubilado.cia_seguro }"
      #   ]
      #   end
      #   pdf.table(data)do
      #     style row(0), :style => :bold, :size => 8
      #     style row(1), :size => 8
      #     self.row_colors = ["DDDDDD","FFFFFF"]
      #     self.header = true
      #   end



      # when 'UNIVERSITARIO'    
      #   pdf.text "Universitario"
      #   data = []
      #   data << [
      #     'Universidad',
      #     'Carrera',
      #     'Encurso',
      #     'Renta familiar',
      #     'Nombre padre',
      #     'Rut padre'
      #   ]

      #   @universitarios.each do |universitario| 
      #   data << [
      #     "#{  universitario.universidad }", 
      #     "#{  universitario.carrera }", 
      #     "#{  universitario.encurso }", 
      #     "#{  universitario.renta_familiar }", 
      #     "#{  universitario.nombre_padre }", 
      #     "#{  universitario.rut_padre }", 
      #   ]
      #   end 
      #   pdf.table(data)do
      #     style row(0), :style => :bold, :size => 8
      #     style row(1), :size => 8
      #     self.row_colors = ["DDDDDD","FFFFFF"]
      #     self.header = true
      #   end
      # end 
      # end
 
      pdf.move_down 20
      pdf.text "Direcciones"
      data = []
      data << [
        'Tipo',
        'Calle num depto',
        'Comuna',
        'Ciudad',
        'Telefono',
        'Celular',
        'Codigo postal',
        'Tipo vivienda',
        'Dividendo arriendo',
        'Casilla',
        'Num correo',
        'Ciudad'
      ]

      @direccions.each do |direccion| 
      data << [
        "#{  direccion.tipo }", 
        "#{  direccion.calle_num_depto }", 
        "#{  direccion.comuna }", 
        "#{  direccion.ciudad }", 
        "#{  direccion.telefono }", 
        "#{  direccion.celular }", 
        "#{  direccion.codigo_postal }", 
        "#{  direccion.tipo_vivienda }", 
        "#{  direccion.dividendo_arriendo }", 
        "#{  direccion.casilla }", 
        "#{  direccion.num_correo }", 
        "#{  direccion.ciudad }"
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 7
        style row(1), :size => 7
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end

      pdf.move_down 20
      pdf.text "Ingresos"
      data = []
      data << [
        'Sueldo fijo mes',
        'Sueldo variable mes',
        'Arriendo',
        'Ventas anuales',
        'Declaracion renta',
        'Honorarios mes',
        'Cuenta cte',
        'Banco',
      ]

      @ingresos.each do |ingreso| 
      data << [
        "#{  ingreso.sueldo_fijo_mes }", 
        "#{  ingreso.sueldo_variable_mes }", 
        "#{  ingreso.arriendo }", 
        "#{  ingreso.vtas_anuales }", 
        "#{  ingreso.declaracion_renta }", 
        "#{  ingreso.honorarios_mes }", 
        "#{  ingreso.cta_cte }", 
        "#{  ingreso.banco }" 
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 


      pdf.move_down 20
      pdf.text "Sociedades"
      data = []
      data << [
        'Tipo',
        'Porcentaje',
        'Capital',
        'Nombre',
        'Rut'
      ]

      @sociedads.each do |sociedad| 
      data << [
        "#{  sociedad.tipo }", 
        "#{  sociedad.porcentaje }", 
        "#{  sociedad.capital }", 
        "#{  sociedad.nombre }", 
        "#{  sociedad.rut }"
      ]
      end 
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 


      pdf.move_down 20
      pdf.text "Bienes Raices"
      data = []

      data << [
        'Tipo',
        'Direccion',
        'Valor comercial',
        'Rol',
        'Hipoteca banco',
      ]

      @bienes_raices.each do |bienes_raice| 
      data << [
        "#{  bienes_raice.tipo }", 
        "#{  bienes_raice.direccion }", 
        "#{  bienes_raice.valor_comercial }", 
        "#{  bienes_raice.rol }", 
        "#{  bienes_raice.hipoteca_banco }"
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 
 

      pdf.move_down 20
      pdf.text "Vehiculos"
      data = []

      data << [
        'Tipo',
        'Marca',
        'Modelo',
        'A',
        'Patente',
        'Valor comercial',
        'Prenda afavor'
      ]

      @vehiculos.each do |vehiculo| 
      data << [
        "#{  vehiculo.tipo }", 
        "#{  vehiculo.marca }", 
        "#{  vehiculo.modelo }", 
        "#{  vehiculo.agno }", 
        "#{  vehiculo.patente }", 
        "#{  vehiculo.valor_comercia }", 
        "#{  vehiculo.prenda_afavor }"
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 
 

      pdf.move_down 20
      pdf.text "Deuda Directa"
      data = []

      data << [
        'Tipo',
        'Institucion',
        'Cupo aprobado',
        'Deuda vigente',
        'Pago mensual',
        'Vencimineto'
      ]

      @deuda_directa.each do |deuda_directum| 
      data << [
        "#{  deuda_directum.tipo }", 
        "#{  deuda_directum.institucion }", 
        "#{  deuda_directum.cupo_aprobado }", 
        "#{  deuda_directum.deuda_vigente }", 
        "#{  deuda_directum.pago_mensual }", 
        "#{  deuda_directum.vencimineto }" 
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 
 

      pdf.move_down 20
      pdf.text "Deuda Indirecta"
      data = []

      data << [
        'Tipo',
        'Institucion',
        'Deuda vigente',
        'Razon social',
        'Rut'
      ]

      @deuda_indirecta.each do |deuda_indirectum| 
      data << [
        "#{  deuda_indirectum.tipo }", 
        "#{  deuda_indirectum.institucion }", 
        "#{  deuda_indirectum.deuda_vigente }", 
        "#{  deuda_indirectum.razon_social }", 
        "#{  deuda_indirectum.rut }"
      ]
      end
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 
 
      pdf.move_down 20
    
      data = []

      data << [
        'IMPORTANTE'
      ]

      data << [
        "Declaro bajo juramento que todos los datos contenidos en este estado de situación,
         como los antecedentes presentados, son fidedignos y que conozco el artículo 160 de la ley
         general de bancos que señala “El que obtuviere créditos de instituciones de Créditos
         Públicas o Privadas, suministrando o proporcionando datos falsos o incompletos acerca de
         su identidad, actividades o estados de situación o patrimonio, ocasionando perjuicios a la
         institución, sufrirá la pena de presidio menor en su grado medio a máximo."
      ]
      
      pdf.table(data)do
        style row(0), :style => :bold, :size => 8
        style row(1), :size => 8
        columns(0..1).align = :center
        self.row_colors = ["DDDDDD","FFFFFF"]
        self.header = true
      end 

    pdf.render_file("#{Rails.root}/tmp/#{p.email}.pdf")
                        
  end  

  def summary_to_csv(email, tipo)
    colsep = ';'
    if tipo == 'xls'
      colsep = '\t'
    end

    @people  = Person.where(email: email)
    p = @people.first
    id = p.id
    @spouses = Spouse.where(person_id: id)
    @direccions = Direccion.where(person_id: id)
    @vehiculos = Vehiculo.where(person_id: id)
    @ingresos = Ingreso.where(person_id: id)
    @sociedads = Sociedad.where(person_id: id)
    @bienes_raices = BienesRaice.where(person_id: id)
    @deuda_directa = DeudaDirectum.where(person_id: id)
    @deuda_indirecta = DeudaIndirectum.where(person_id: id)
    # @employment_statuses = EmploymentStatus.where(email: .email)
   
    @dependents = Dependent.where(person_id: id)
    @independents = Independent.where(person_id: id)
    @jubilados = Jubilado.where(person_id: id)
    @universitarios = Universitario.where(person_id: id)

    
    CSV.open("#{Rails.root}/tmp/#{p.email}.#{tipo}", "wb", { :col_sep => ";" }) do |csv|
  
      csv << ["Estado de Situacion Capitalizarme.com"]
      csv << [" "]
      csv << ["Datos Personales"]
      csv << ["email:", "#{p.email}"]
      csv << [""]
     
      csv << ['Rut',
              'Nombres',
              'Apellidos',
              'Genero', 
              'Nacionalidad',
              'Actividad', 
              'Educacion', 
              'Universidad', 
              'Pais Origen', 
              'Pais Residencia', 
              'Profesion', 
              'Personas dependientes',
              'N Hijos',
              'Estado Civil',
              'Regimen Matrimonial',
              'Fecha Nacimiento']
      @people.each do |person| 
      csv << [
        "#{ person.rut }", 
        "#{ person.first_name}", 
        "#{ person.last_name }",
        "#{ person.gender  }",
        "#{ person.nationality}", 
        "#{ person.economic_activity}", 
        "#{ person.education }",
        "#{ person.university }",
        "#{ person.origin_country }",
        "#{ person.resident_country }",
        "#{ person.profession }",
        "#{ person.dependents   }",
        "#{ person.number_of_children}", 
        "#{ person.marital_status }",
        "#{ person.matrimonial_regime }",
        "#{ person.date_birth }"
         ] 
      end

      csv << [""]

      csv << ["Datos Conyugue"]


      csv << [
        'Rut',
        'Nombres',
        'Apellidos',
        'Genero',
        'Nacionalidad',
        'Actividad',
        'Educacion',
        'Universidad',
        'Pais Origen',
        'Pais Residencia'
      ]

      @spouses.each do |person| 
      csv << [
          "#{  person.rut }", 
          "#{  person.first_name }", 
          "#{  person.last_name }", 
          "#{  person.gender }", 
          "#{  person.nationality }", 
          "#{  person.economic_activity }", 
          "#{  person.education }", 
          "#{  person.university }",  
          "#{  person.origin_country }", 
          "#{  person.resident_country }", 
      ]
      end

      csv << [""]
      # @employment_statuses.each do |employment_status| 

      # case employment_status.name 
      # when 'DEPENDIENTE' 
        csv << ["Trabajador Dependiente"]
 
        csv << [
     
          'Empleador',
          'Rut empleador',
          'Giro empresa',
          'Direccion empresa',
          'Tipo contrato',
          'Cargo',
          'Fecha ingreso',
          'Fecha ingreso anterior',
          'Fecha termino anterior',
        ]

        @dependents.each do |dependent|
        csv << [
     
          "#{  dependent.empleador }", 
          "#{  dependent.rut_empleador }", 
          "#{  dependent.giro_empresa }", 
          "#{  dependent.direccion_empresa }", 
          "#{  dependent.tipo_contrato }", 
          "#{  dependent.cargo }", 
          "#{  dependent.fecha_ingreso }", 
          "#{  dependent.fecha_ingreso_anterior }", 
          "#{  dependent.fecha_termino_anterior }"
        ]
        end 
    
      # when 'INDEPENDIENTE' 
      #   csv << ["Trabajador Independiente"]
      #   csv << [
      #     'Tipo rentista',
      #     'Tipo actividad',
      #     'Giro actividad',
      #     'Fecha inicio rubro',
      #     'Fecha inicio actividad',
      #     'Nombre empleador anterior',
      #     'Cargo',
      #     'Antiguedad'
      #   ]

      #   @independents.each do |independent|
      #   csv << [
      #     "#{  independent.tipo_rentista }", 
      #     "#{  independent.tipo_actividad }", 
      #     "#{  independent.giro_actividad }", 
      #     "#{  independent.fecha_inicio_rubro }", 
      #     "#{  independent.fecha_inicio_actividad }", 
      #     "#{  independent.nombre_empleador_anterior }", 
      #     "#{  independent.cargo }", 
      #     "#{  independent.antiguedad }" 
      #   ]
      #   end 

      # when 'JUBILADO'  

      #   csv << ["Jubilado"]

      #   csv << [
      #     'Ultimo empleador',
      #     'Institucion pagadora',
      #     'Afp',
      #     'Cia seguro'
      #   ]

      #   @jubilados.each do |jubilado| 
      #   csv << [
     
      #     "#{  jubilado.ultimo_empleador }", 
      #     "#{  jubilado.institucion_pagadora }", 
      #     "#{  jubilado.afp }", 
      #     "#{  jubilado.cia_seguro }"
      #   ]
      #   end


      # when 'UNIVERSITARIO'    
      #   csv << ["Universitario"]
      #   csv << [
      #     'Universidad',
      #     'Carrera',
      #     'Encurso',
      #     'Renta familiar',
      #     'Nombre padre',
      #     'Rut padre'
      #   ]

      #   @universitarios.each do |universitario| 
      #   csv << [
      #     "#{  universitario.universidad }", 
      #     "#{  universitario.carrera }", 
      #     "#{  universitario.encurso }", 
      #     "#{  universitario.renta_familiar }", 
      #     "#{  universitario.nombre_padre }", 
      #     "#{  universitario.rut_padre }", 
      #   ]
      #   end 
      # end 
      # end
 
      csv << [""]
      csv << ["Direcciones"]

      csv << [
        'Tipo',
        'Calle num depto',
        'Comuna',
        'Ciudad',
        'Telefono',
        'Celular',
        'Codigo postal',
        'Tipo vivienda',
        'Dividendo arriendo',
        'Casilla',
        'Num correo',
        'Ciudad'
      ]

      @direccions.each do |direccion| 
      csv << [
        "#{  direccion.tipo }", 
        "#{  direccion.calle_num_depto }", 
        "#{  direccion.comuna }", 
        "#{  direccion.ciudad }", 
        "#{  direccion.telefono }", 
        "#{  direccion.celular }", 
        "#{  direccion.codigo_postal }", 
        "#{  direccion.tipo_vivienda }", 
        "#{  direccion.dividendo_arriendo }", 
        "#{  direccion.casilla }", 
        "#{  direccion.num_correo }", 
        "#{  direccion.ciudad }"
      ]
      end

      csv << [""]
      csv << ["Ingresos"]

      csv << [
        'Sueldo fijo mes',
        'Sueldo variable mes',
        'Arriendo',
        'Ventas anuales',
        'Declaracion renta',
        'Honorarios mes',
        'Cuenta cte',
        'Banco',
      ]

      @ingresos.each do |ingreso| 
      csv << [
        "#{  ingreso.sueldo_fijo_mes }", 
        "#{  ingreso.sueldo_variable_mes }", 
        "#{  ingreso.arriendo }", 
        "#{  ingreso.vtas_anuales }", 
        "#{  ingreso.declaracion_renta }", 
        "#{  ingreso.honorarios_mes }", 
        "#{  ingreso.cta_cte }", 
        "#{  ingreso.banco }" 
      ]
      end 


      csv << [""]
      csv << ["Sociedades"]
      csv << [
        'Tipo',
        'Porcentaje',
        'Capital',
        'Nombre',
        'Rut'
      ]

      @sociedads.each do |sociedad| 
      csv << [
        "#{  sociedad.tipo }", 
        "#{  sociedad.porcentaje }", 
        "#{  sociedad.capital }", 
        "#{  sociedad.nombre }", 
        "#{  sociedad.rut }"
      ]
      end 

      csv << [""]
      csv << ["Bienes Raices"]

      csv << [
        'Tipo',
        'Direccion',
        'Valor comercial',
        'Rol',
        'Hipoteca banco',
      ]

      @bienes_raices.each do |bienes_raice| 
      csv << [
        "#{  bienes_raice.tipo }", 
        "#{  bienes_raice.direccion }", 
        "#{  bienes_raice.valor_comercial }", 
        "#{  bienes_raice.rol }", 
        "#{  bienes_raice.hipoteca_banco }"
      ]
      end 

      csv << [""]
      csv << ["Vehiculos"]

      csv << [
        'Tipo',
        'Marca',
        'Modelo',
        'A',
        'Patente',
        'Valor comercia',
        'Prenda afavor'
      ]

      @vehiculos.each do |vehiculo| 
      csv << [
        "#{  vehiculo.tipo }", 
        "#{  vehiculo.marca }", 
        "#{  vehiculo.modelo }", 
        "#{  vehiculo.agno }", 
        "#{  vehiculo.patente }", 
        "#{  vehiculo.valor_comercia }", 
        "#{  vehiculo.prenda_afavor }"
      ]
      end 

      csv << [""]
      csv << ["Deuda Directa"]

      csv << [
        'Tipo',
        'Institucion',
        'Cupo aprobado',
        'Deuda vigente',
        'Pago mensual',
        'Vencimineto'
      ]

      @deuda_directa.each do |deuda_directum| 
      csv << [
        "#{  deuda_directum.tipo }", 
        "#{  deuda_directum.institucion }", 
        "#{  deuda_directum.cupo_aprobado }", 
        "#{  deuda_directum.deuda_vigente }", 
        "#{  deuda_directum.pago_mensual }", 
        "#{  deuda_directum.vencimineto }" 
      ]
      end 

      csv << [""]
      csv << ["Deuda Indirecta"]

      csv << [
        'Tipo',
        'Institucion',
        'Deuda vigente',
        'Razon social',
        'Rut'
      ]

      @deuda_indirecta.each do |deuda_indirectum| 
      csv << [
        "#{  deuda_indirectum.tipo }", 
        "#{  deuda_indirectum.institucion }", 
        "#{  deuda_indirectum.deuda_vigente }", 
        "#{  deuda_indirectum.razon_social }", 
        "#{  deuda_indirectum.rut }"
      ]
      end 
    end
  end





end
