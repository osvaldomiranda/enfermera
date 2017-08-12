class Workplace < ActiveRecord::Base

  belongs_to :office

  has_many :wpdocument, dependent: :destroy
  has_many :wpdiscounts, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :incomes
  has_many :fees, through: :people

  scope :with_codwp, -> with_codwp { where(cod_wp: with_codwp) if with_codwp.present?}
  scope :publicos, ->publicos { where.not(cod_serv_salud: nil) if publicos=='SI' }
  scope :privados, ->privados { where(cod_serv_salud: nil) if privados=='SI' }

 
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

  def create_file 
    if self.cod_serv_salud.present?
      fecha = Time.now.strftime("%Y%m%d")
      rut = "7700296008"
      uno = "1" 
      person_count = self.people.count()
      cuotas = person_count * 6500  
      people = person_count.to_s.rjust(10, '0')
      total =  cuotas.to_s.rjust(12, '0')

      code1 = self.cod_wp
      code2 = '00' + self.cod_serv_salud
      head  = fecha + rut + uno + people + total + "00"
      
      wpfile = File.new("#{self.cod_wp}_wp_file.txt", "w") 
      wpfile.puts head
      self.people.each do |person| 
        body = fecha + rut + code1 + person.rut.gsub('-','').to_s.rjust(9, '0') + code2 + "0000000000000P" + "00000650000       10102011"
        wpfile.puts body
      end
      wpfile.close

      # wpDiscount = Wpdiscount.new()
      # data = File.open("#{Rails.root}/#{self.cod_wp}_wp_file.txt")
      # wpDiscount.discountfile = data
      # wpDiscount.workplace_id = self.id
      # if wpDiscount.save
      #   File.delete("#{Rails.root}/#{self.cod_wp}_wp_file.txt")
      # end
    end    


    
    wpfilertf = File.new("#{self.cod_wp}_wp_file.rtf", "w") 

    wpfilertf.puts "Colegio de enfermeras de Chile A.G."
    wpfilertf.puts "Descuentos colegiadas"
    wpfilertf.puts "RUT_FUNC  Nombre_colegiada  Monto_dcto"   

    self.people.each do |person|
      wpfilertf.puts person.rut + ' ' + person.fullname + ' $6.500.-'
    end

    wpfilertf.close

  end 

end
