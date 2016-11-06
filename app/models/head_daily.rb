class HeadDaily < ActiveRecord::Base
  belongs_to :user

  has_many :dailies, dependent: :destroy
  mount_uploader :documento, DocumentUploader

  after_save :define_estado
  
  scope :with_tipo, -> with_tipo { where(tipo: with_tipo) if with_tipo.present?}
  scope :with_numero, -> with_numero { where(numero: with_numero) if with_numero.present?}

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


  def self.next_ingreso
    h = HeadDaily.where(tipo: 'INGRESO').order("numero ASC").last
    if h.present?
      n = h.numero + 1
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

  def eliminar
    self.dailies.each do |daily|
      if daily.income.present?
        daily.income.fees.each do |fee|
          fee.delete
        end
        daily.income.delete
      end  
      
      daily.delete
    end
    self.delete
  end

  def confirmar
    self.estado='CONFIRMADO'
    self.sav
  end

  def define_estado
    if current_user.role?(:admin)
      self.estado = 'CONFIRMADO'
    else
      self.estado = 'PENDIENTE'
    end  
    self.save
  end

end
