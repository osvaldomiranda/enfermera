class Workplace < ActiveRecord::Base

  belongs_to :office

  has_many :wpdocument, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :incomes
  has_many :fees, through: :people

 
  def self.workplaces_option_for_select
    # filtrar por ciudad
    Workplace.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
  end  

  def self.workplaces_for_office(regional)
    # filtrar por ciudad
    if regional.present?
      Workplace.where(office_id: regional).order(nombre: :asc).map {|t| [t.nombre, t.id]}
    else
      Workplace.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
    end    
  end   

end
