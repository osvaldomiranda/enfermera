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
    mespago= mes.map{|m| "#{m}-#{fecha-5}"}
    mespago+= mes.map{|m| "#{m}-#{fecha-4}"}
    mespago+= mes.map{|m| "#{m}-#{fecha-3}"}
    mespago+= mes.map{|m| "#{m}-#{fecha-2}"}
    mespago+= mes.map{|m| "#{m}-#{fecha-1}"}
    mespago+= mes.map{|m| "#{m}-#{fecha}"}
    mespago+= mes.map{|m| "#{m}-#{fecha+1}"}
    mespago.each.map { |t| [t, t] }
  end  

  TIPOPAGO      = ['Deposito', 'Cheque', 'Transferencia', 'Web Pay']
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

  MEDIOPAGO      = ['Deposito', 'Cheque', 'Transferencia', 'Web Pay']
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
  CUOTAS[5] = ["6 Cuotas $#{valor*6}.-", valor*6]
  CUOTAS[6] = ["7 Cuotas $#{valor*7}.-", valor*7]
  CUOTAS[7] = ["8 Cuotas $#{valor*8}.-", valor*8]
  CUOTAS[8] = ["9 Cuotas $#{valor*9}.-", valor*9]
  CUOTAS[9] = ["10 Cuotas $#{valor*10}.-", valor*10]
  CUOTAS[10] = ["11 Cuotas $#{valor*11}.-", valor*11]
  CUOTAS[11] = ["12 Cuotas $#{valor*12}.-", valor*12]

  def self.cuotas_options_for_select(admin)
    if admin == 'SI'
      CUOTAS[12] = ["1 Cuotas $6000.-", 6000]
      CUOTAS[13] = ["2 Cuotas $#{6000*2}.-", 6000*2]
      CUOTAS[14] = ["3 Cuotas $#{6000*3}.-", 6000*3]
      CUOTAS[15] = ["4 Cuotas $#{6000*4}.-", 6000*4]
      CUOTAS[16] = ["5 Cuotas $#{6000*5}.-", 6000*5]
      CUOTAS[17] = ["6 Cuotas $#{6000*6}.-", 6000*6]
      CUOTAS[18] = ["7 Cuotas $#{6000*7}.-", 6000*7]
      CUOTAS[19] = ["8 Cuotas $#{6000*8}.-", 6000*8]
      CUOTAS[20] = ["9 Cuotas $#{6000*9}.-", 6000*9]
      CUOTAS[21] = ["10 Cuotas $#{6000*10}.-", 6000*10]
      CUOTAS[22] = ["11 Cuotas $#{6000*11}.-", 6000*11]
      CUOTAS[23] = ["12 Cuotas $#{6000*12}.-", 6000*12]
      
      CUOTAS[24] = ["1 Cuotas $5000.-", 5000]
      CUOTAS[25] = ["2 Cuotas $#{5000*2}.-", 5000*2]
      CUOTAS[26] = ["3 Cuotas $#{5000*3}.-", 5000*3]
      CUOTAS[27] = ["4 Cuotas $#{5000*4}.-", 5000*4]
      CUOTAS[28] = ["5 Cuotas $#{5000*5}.-", 5000*5]
      CUOTAS[29] = ["6 Cuotas $#{5000*6}.-", 5000*6]
      CUOTAS[30] = ["7 Cuotas $#{5000*7}.-", 5000*7]
      CUOTAS[31] = ["8 Cuotas $#{5000*8}.-", 5000*8]
      CUOTAS[32] = ["9 Cuotas $#{5000*9}.-", 5000*9]
      CUOTAS[33] = ["10 Cuotas $#{5000*10}.-", 5000*10]
      CUOTAS[34] = ["11 Cuotas $#{5000*11}.-", 5000*11]
      CUOTAS[35] = ["12 Cuotas $#{5000*12}.-", 5000*12]

      CUOTAS[36] = ["1 Cuotas $7000.-", 7000]
      CUOTAS[37] = ["2 Cuotas $#{7000*2}.-", 7000*2]
      CUOTAS[38] = ["3 Cuotas $#{7000*3}.-", 7000*3]
      CUOTAS[39] = ["4 Cuotas $#{7000*4}.-", 7000*4]
      CUOTAS[40] = ["5 Cuotas $#{7000*5}.-", 7000*5]
      CUOTAS[41] = ["6 Cuotas $#{7000*6}.-", 7000*6]
      CUOTAS[42] = ["7 Cuotas $#{7000*7}.-", 7000*7]
      CUOTAS[43] = ["8 Cuotas $#{7000*8}.-", 7000*8]
      CUOTAS[44] = ["9 Cuotas $#{7000*9}.-", 7000*9]
      CUOTAS[45] = ["10 Cuotas $#{7000*10}.-", 7000*10]
      CUOTAS[46] = ["11 Cuotas $#{7000*11}.-", 7000*11]
      CUOTAS[47] = ["12 Cuotas $#{7000*12}.-", 7000*12]

     CUOTAS[48] = [" 2012 - 2013 Cuota $3.750", 3750]
     CUOTAS[49] = [" Jubilada 1 Cuota $1.500", 1500]
     
     CUOTAS[50] = [" Jubilada 2 Cuota $3000", 3000]
     CUOTAS[51] = [" Jubilada 3 Cuota $4500", 4500]
     CUOTAS[52] = [" Jubilada 4 Cuota $6000", 6000]
     CUOTAS[53] = [" Jubilada 5 Cuota $7500", 7500]
     CUOTAS[54] = [" Jubilada 6 Cuota $9000", 9000]
     CUOTAS[55] = [" Jubilada 7 Cuota $10500", 10500]
     CUOTAS[56] = [" Jubilada 8 Cuota $12000", 12000]
     CUOTAS[57] = [" Jubilada 9 Cuota $13500", 13500]
     CUOTAS[58] = [" Jubilada 10 Cuota $15000", 15000]
     CUOTAS[59] = [" Jubilada 11 Cuota $16500", 16500]
     CUOTAS[60] = [" Jubilada 12 Cuota $18000", 18000]


    end

    #GENDERS.to_enum.with_index(0).to_a
    CUOTAS.each.map { |t| [t[0], t[1]] }
  end  

  def dailycreate
    # Acá se debe crear un asiento contable si el ingreso no es de Valpo

    workplace = Workplace.find(self.workplace_id)
  
      head_daily = HeadDaily.new
      head_daily.user_id = self.user_id
      head_daily.tipo = "INGRESO"
      head_daily.numero = HeadDaily.next_ingreso
      head_daily.banco = self.banco 
      head_daily.mediopago = self.mediopago
      head_daily.documento = self.document

      if workplace.present?
        head_daily.office_id = workplace.office.id
        if workplace.office.codigo == "VPO"
          head_daily.folio_office = HeadDaily.next_ingreso_office
        end
      end
      
      user = User.find(self.user_id)
      if user.role?(:admin)
        head_daily.estado = 'CONFIRMADO'
      else
        head_daily.estado = 'PENDIENTE'
      end    

      person = Person.find(self.person_id)
      if self.tipo == "Colegiada"
        head_daily.recibidode = person.fullname
      else
        if  self.tipo == "Incompleta"
          head_daily.recibidode = person.fullname
          head_daily.rut = person.rut
        else 
          head_daily.recibidode = workplace.nombre
        end  
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
        if self.tipo == "Incompleta"
          daily.por = "Pago cuotas incompletas: #{person.fullname}" 
        else  
          daily.por = "Pago cuotas: #{workplace.nombre}"
        end
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
      if self.tipo == "Incompleta"
        daily.account_id = Account.find_by_codigo('2040103').id
      else  
        daily.account_id = Account.find_by_codigo('2040102').id
      end
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
        # PersonMailer.pay_user(user.person, head_daily).deliver
      else  
        if self.tipo == "Incompleta"
          daily.por = "Pago cuotas incompletas: #{person.fullname}" 
        else  
          daily.por = "Pago cuotas: #{workplace.nombre}"
        end
      end  
      daily.save
 
  end 

  def head_daily
    daily = Daily.where(income_id: self.id).first
    if daily.present?
      daily.head_daily.numero
    else
      nil  
    end
  end

end
