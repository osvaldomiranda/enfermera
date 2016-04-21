class Income < ActiveRecord::Base
  belongs_to :person
  belongs_to :workplace
  belongs_to :user

  has_many :fees

  mount_uploader :document, DocumentUploader 

  TIPOPAGO      = ['Deposito', 'Cheque', 'Transferencia']
  def self.tipopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  BANCO      = ['BANCO DE CHILE', 'BANCO INTERNACIONAL', 'BANCO SCOTIABANK CHILE', 'BANCO DE CREDITO E INVERSIONES', 
  				      'BANCO CORPBANCA','BANCO BICE','HSBC BANK (CHILE)', 'BANCO SANTANDER-CHILE', 'BANCO ITAÚ CHILE',
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

  valor = Currentfee.last.valor.present? ?  Currentfee.last.valor : 0
  CUOTAS=[]
  CUOTAS[0] = ["1 Cuota   $#{valor}.-" , valor]
  CUOTAS[1] = ["2 Cuotas $#{valor*2}.-", valor*2]
  CUOTAS[2] = ["3 Cuotas $#{valor*3}.-", valor*3]
  CUOTAS[3] = ["4 Cuotas $#{valor*4}.-", valor*4]
  CUOTAS[4] = ["5 Cuotas $#{valor*5}.-", valor*5]
  def self.cuouas_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    CUOTAS.each.map { |t| [t[0], t[1]] }
  end   


end
