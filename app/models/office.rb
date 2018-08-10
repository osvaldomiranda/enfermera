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

  def totalfees
    total = 0
    self.workplaces.each do |workplace|
      workplace.fees.each do |fee|
        if fee.mescuota.present?
          if fee.mescuota.year==2017
            total +=  fee.monto 
          end
        end
      end
    end  
    return total
  end              
 
end
