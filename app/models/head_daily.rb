class HeadDaily < ActiveRecord::Base
  belongs_to :user
  has_many :dailies

  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      h = HeadDaily.where(numero: rowHash["numero"]).first
      if !h.present?
        h = HeadDaily.new
        h.numero = rowHash["numero"]
        h.user_id = 1
        h.save
      end
    end
  end

  def self.next_ingreso
    h = HeadDaily.where(tipo: 'INGRESO').last
    if h.present?
      n = h.numero + 1
    else
      n = 1  
    end  
    return n
  end

  def self.next_egreso
    h = HeadDaily.where(tipo: 'EGRESO').last
    if h.present?
      n = h.numero + 1
    else
      n = 1  
    end  
    return n
  end
end
