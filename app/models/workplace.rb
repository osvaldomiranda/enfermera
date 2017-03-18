class Workplace < ActiveRecord::Base

  belongs_to :office

  has_many :wpdocument, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :incomes
  has_many :fees, through: :people

  scope :with_codwp, -> with_codwp { where(cod_wp: with_codwp) if with_codwp.present?}

 
  def self.workplaces_option_for_name
    # filtrar por ciudad
    Workplace.all.order(nombre: :asc).map {|t| [t.nombre, t.id]}
  end  

  def self.workplaces_option_for_code(user)
    # filtrar por ciudad
    if user.rol > 7
      Workplace.all.order(cod_wp: :asc).map {|t| ["#{t.cod_wp} #{t.nombre}", t.id]}
    else
      Workplace.where(office_id: user.office.id).order(cod_wp: :asc).map {|t| ["#{t.cod_wp} #{t.nombre}", t.id]}
    end  
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
