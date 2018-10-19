class Office < ActiveRecord::Base
  has_many :workplaces
  has_many :expenses
  has_many :incomes
  has_many :regional_councils
  has_many :people, :through => :workplaces
  has_many :fees, :through => :workplaces
  has_many :benefits

  def self.office_option_for_select
    Office.all.order(nombre: :asc).map {|t| t.nombre}
  end 


  def self.options_for_select(user)
    if user.role?(:national_admin) || user.role?(:web)
      Office.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
    else
      Office.where(id: user.office.id).map {|t| [t.nombre, t.id]}
    end  
  end 

  def self.region_options_for_select
    Region.all.map { |r| [r.nombre, r.nombre] }
  end   

  def totalfees(month, year)
    if month == '01' || month == '03' || month == '05' || month == '07' || month == '08' || month == '10' || month == '12'
      day='31'
    end

    if month == '04' || month == '06' || month == '09' || month == '11' 
      day='30'
    end

    if month == '02'
      day='28'
    end

    total = 0
    self.workplaces.each do |workplace|
      workplace.people.each do |people|
        fee = people.fees.where(mescuota: Date.parse("01-#{month}-#{year}")..Date.parse("#{day}-#{month}-#{year}")).first
        if fee.present?
          total +=  fee.monto
        end   
      end
    end  
    return total
  end              
 
end
