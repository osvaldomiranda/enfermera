class Daily < ActiveRecord::Base
  belongs_to :cost_center
  belongs_to :account
  belongs_to :office
  belongs_to :income
  belongs_to :expense

  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      cost_center = CostCenter.where(codigo: rowHash["centro_costo"]).first
      account = Account.where(codigo: rowHash["cuenta"]).first
      head_daily = HeadDaily.where(numero: rowHash["numero"]).first

        d = Daily.new
        if cost_center.present?
          d.cost_center_id = cost_center.id
        end  
        d.account_id = account.id
        d.head_daily_id = head_daily.id

        d.tipo = "EGRESO"
        d.numero = rowHash["numero"]
        d.fecha = Date.parse(rowHash["fecha"]) 
        d.debe = rowHash["debe"]  
        d.haber = rowHash["haber"] 
        d.paguesea = rowHash["paguesea"]  
        d.por = rowHash["por"] 
        d.save
 
    end
  end
end
