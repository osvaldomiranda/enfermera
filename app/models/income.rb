class Income < ActiveRecord::Base
  belongs_to :person
  belongs_to :workplace
  belongs_to :user
  belongs_to :office
  
  has_many :fees

  mount_uploader :document, DocumentUploader 

  after_save :dailycreate


  def self.mescuota_options_for_select
    fecha = DateTime.now.year
    mes = [1,2,3,4,5,6,7,8,9,10,11,12]
    mespago = mes.map{|m| "#{m}-#{fecha-1}"}
    mespago+= mes.map{|m| "#{m}-#{fecha}"}
    mespago+= mes.map{|m| "#{m}-#{fecha+1}"}
    mespago.each.map { |t| [t, t] }
  end  

  TIPOPAGO      = ['Deposito', 'Cheque', 'Transferencia']
  def self.tipopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  BANCO      = ['BANCO DE CHILE', 'BANCO INTERNACIONAL', 'BANCO SCOTIABANK CHILE', 'BANCO DE CREDITO E INVERSIONES', 
  				      'BANCO CORPBANCA','BANCO BICE','HSBC BANK (CHILE)', 'BANCO SANTANDER-CHILE', 'BANCO ITAU CHILE',
				        'BANCO SECURITY', 'BANCO FALABELLA', 'DEUTSCHE BANK (CHILE)', 'BANCO RIPLEY', 'RABOBANK CHILE', 
				        'BANCO CONSORCIO', 'BANCO PENTA', 'BANCO PARIS', 'BANCO BBVA','BANCO BTG PACTUAL CHILE', 'BANCO ESTADO' ]

  def self.banco_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    BANCO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  MEDIOPAGO      = ['Deposito', 'Cheque', 'Transferencia']
  def self.mediopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MEDIOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  valor = Currentfee.last.present? ?  Currentfee.last.valor : 0
  CUOTAS=[]
  CUOTAS[0] = ["1 Cuota   $#{valor}.-" , valor]
  CUOTAS[1] = ["2 Cuotas $#{valor*2}.-", valor*2]
  CUOTAS[2] = ["3 Cuotas $#{valor*3}.-", valor*3]
  CUOTAS[3] = ["4 Cuotas $#{valor*4}.-", valor*4]
  CUOTAS[4] = ["5 Cuotas $#{valor*5}.-", valor*5]
  def self.cuotas_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    CUOTAS.each.map { |t| [t[0], t[1]] }
  end  

  def dailycreate
    # Acá se debe crear un asiento contable si el ingreso no es de Valpo

    workplace = Workplace.find(self.workplace_id)

    # if workplace.office.codigo != "VPO"
      head_daily = HeadDaily.new
      head_daily.user_id = self.user_id
      head_daily.tipo = "INGRESO"
      head_daily.numero = HeadDaily.next_ingreso
      head_daily.banco = self.banco 
      head_daily.mediopago = self.mediopago
      head_daily.documento = self.document

      user = User.find(self.user_id)
      if user.role?(:admin)
        head_daily.estado = 'CONFIRMADO'
      else
        head_daily.estado = 'PENDIENTE'
      end    

      if self.tipo == "Colegiada"
        person = Person.find(self.person_id)
        head_daily.recibidode = person.fullname
      else  
        head_daily.recibidode = workplace.nombre 
      end   

      head_daily.save

      daily = Daily.new
      daily.numero = head_daily.numero
      daily.fecha = self.fecha_contable
      daily.account_id =  Account.find_by_codigo('1010101').id
      daily.debe = self.monto
      daily.haber = 0 
      daily.detalle = "Ingreso #{self.id}"

      if self.tipo == "Colegiada"
        daily.por = "Pago cuotas: #{person.fullname}" 
      else  
        daily.por = "Pago cuotas: #{workplace.nombre}"
      end  
      daily.tipo = "INGRESO"
      daily.office_id = workplace.office.id 
      daily.income_id = self.id
      daily.banco = self.banco
      daily.head_daily_id = head_daily.id
      daily.save

      daily = Daily.new
      daily.numero = head_daily.numero
      daily.fecha = self.fecha_contable
      daily.account_id = Account.find_by_codigo('2040102').id
      daily.debe  = 0
      daily.haber = self.monto
      daily.detalle = "Ingreso #{self.id}"
      daily.tipo = "INGRESO"
      daily.office_id = workplace.office.id 
      daily.income_id = self.id
      daily.banco = self.banco
      daily.head_daily_id = head_daily.id

      if self.tipo == "Colegiada"
        daily.por = "Pago cuotas: #{person.fullname}" 
      else  
        daily.por = "Pago cuotas: #{workplace.nombre}"
      end  
      daily.save
    # end  


  end 


end
