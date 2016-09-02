class Office < ActiveRecord::Base
  has_many :workplaces
  has_many :expenses
  has_many :incomes
  has_many :people, :through => :workplaces
  has_many :fees, :through => :workplaces

  def self.office_option_for_select
    Office.all.order(nombre: :asc).map {|t| t.nombre}
  end 


  def self.options_for_select(user)
    if user.role?(:national_admin)
      Office.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
    else
      Office.where(id: user.office.id).map {|t| [t.nombre, t.id]}
    end  
  end 

  def self.region_options_for_select
    Region.all.map { |r| [r.nombre, r.nombre] }
  end   
 
end
