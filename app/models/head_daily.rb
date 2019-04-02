class HeadDaily < ActiveRecord::Base
  belongs_to :user

  has_many :dailies, dependent: :destroy
  mount_uploader :documento, DocumentUploader

  # before_save :set_numero
  
  scope :with_tipo, -> with_tipo { where(tipo: with_tipo) if with_tipo.present?}
  scope :with_origen, -> with_origen { where(user_id: with_origen) if with_origen.present?}
  scope :with_estado, -> with_estado { where(estado: with_estado) if with_estado.present?}
  scope :with_numero, -> with_numero { where(numero: with_numero) if with_numero.present?}
  scope :with_por, -> with_por { where('lower(por) like ?', '%'+with_por.downcase+'%') if with_por.present?}
  scope :with_medio, -> with_medio { where('lower(mediopago) like ?', '%'+with_medio.downcase+'%') if with_medio.present?}
  scope :with_cheque, -> with_cheque { where('lower(numcheque) like ?', '%'+with_cheque.downcase+'%') if with_cheque.present?}



  def monto
    self.dailies.sum(:haber)
  end 


  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      h = HeadDaily.where(numero: rowHash["numero"], tipo:"EGRESO").first
      office = Office.where(codigo: rowHash["region"]).first
      workplace = Workplace.where(cod_wp: rowHash["wp"]).first
      if !h.present?
        h = HeadDaily.new
        h.numero = rowHash["numero"]
        h.tipo = 'EGRESO'
        h.recibidode = rowHash["glosa"]
        h.office_id = office.present? ? office.id : nil
        h.workplace_id = workplace.present? ? workplace.id : nil
        h.user_id = 1
        h.save
      end
    end
  end

  def self.import_egreso(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      h = HeadDaily.where(numero: rowHash["numero"], tipo:"EGRESO").first
      if !h.present?
        h = HeadDaily.new
        h.numero = rowHash["numero"]
        h.tipo = 'EGRESO'
        h.paguesea = rowHash["glosa"]
        h.user_id = 1
        h.save
      end
    end
  end




  def eliminar
    self.dailies.each do |daily|
      if daily.income.present?
        daily.income.fees.each do |fee|
          fee.delete
        end
        daily.income.delete
      end  
      daily.detalle = "COMPROBANTE NULO"
      daily.estado = "NULO"
      daily.save
    end
    self.estado = "NULO"
    self.save
  end

  def confirmar
    self.estado='CONFIRMADO'
    self.save
  end

  def self.user_creation
    User.where(id: HeadDaily.select(:user_id).distinct).where('roles_mask>4').map{|u| [u.email,u.id]}
  end

  def self.next_ingreso
    h = HeadDaily.where(tipo: 'INGRESO').where(folio_office: nil).order("numero ASC").last   
    if h.present?   
      n = h.numero + 1    
    else    
      n = 1     
    end     
    return n    
  end

  def self.next_ingreso_office
    h = HeadDaily.where(tipo: 'INGRESO').where.not(folio_office: nil).order("folio_office ASC").last   
    if h.present?   
      n = h.folio_office + 1    
    else    
      n = 1     
    end     
    return n    
  end     
    
  def self.next_egreso   
    h = HeadDaily.where(tipo: 'EGRESO').order("numero ASC").last    
    if h.present?   
      n = h.numero + 1    
    else    
      n = 1     
    end     
    return n    
  end

  def set_numero
    if self.tipo == 'EGRESO'
      h = HeadDaily.where(tipo: 'EGRESO').order("numero ASC").last
    else 
      h = HeadDaily.where(tipo: 'INGRESO').order("numero ASC").last
    end
    if h.present?
      n = h.numero + 1
    else
      n = 1  
    end 
    self.numero = n
  end
end
