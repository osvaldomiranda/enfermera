class Income < ActiveRecord::Base
  belongs_to :person
  belongs_to :workplace
  belongs_to :user


  TIPOPAGO      = ['Deposito', 'Cheque', 'Transferencia']
  def self.tipopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  BANCO      = ['BANCO DE CHILE', 'BANCO INTERNACIONAL', 'BANCO SCOTIABANK CHILE', 'BANCO DE CREDITO E INVERSIONES', 
  				'BANCO CORPBANCA','BANCO BICE','HSBC BANK (CHILE)', 'BANCO SANTANDER-CHILE', 'BANCO ITAÚ CHILE',
				'BANCO SECURITY', 'BANCO FALABELLA', 'DEUTSCHE BANK (CHILE)', 'BANCO RIPLEY', 'RABOBANK CHILE', 
				'BANCO CONSORCIO', 'BANCO PENTA', 'BANCO PARIS', 'BANCO BBVA','BANCO BTG PACTUAL CHILE' ]

  def self.banco_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    BANCO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  MEDIOPAGO      = ['Deposito', 'Cheque', 'Transferencia']
  def self.mediopago_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    MEDIOPAGO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

end
