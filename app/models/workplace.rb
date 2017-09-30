# encoding: utf-8
class Workplace < ActiveRecord::Base

  belongs_to :office

  has_many :wpdocument, dependent: :destroy
  has_many :wpdiscounts, dependent: :destroy
  has_many :wpemails, dependent: :destroy
  has_many :people, dependent: :destroy
  
  has_many :incomes
  has_many :fees, through: :people


  scope :with_codwp, -> with_codwp { where(cod_wp: with_codwp) if with_codwp.present?}
  scope :publicos, ->publicos { where(serv_salud: 'SI') if publicos=='SI' }
  scope :privados, ->privados { where(serv_salud: nil) if privados=='SI' }

 
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
    if self.serv_salud == "SI"
      people_ss = Person.where(workplace_id: Workplace.select(:id).where(cod_serv_salud: self.cod_serv_salud))
      fecha = Time.now.strftime("%Y%m%d")
      rut = "7700296008"
      uno = "1" 
      person_count = people_ss.count()
      cuotas = person_count * 6500  
      people = person_count.to_s.rjust(10, '0')
      total =  cuotas.to_s.rjust(12, '0')

      code1 = self.cod_wp
      code2 = '00' + self.cod_serv_salud
      head  = fecha + rut + uno + people + total + "00"
      
      wpfile = File.new("#{self.cod_wp}_wp_file.txt", "w") 
      wpfile.puts head

      people_ss.each do |person| 
        body = fecha + rut + code1 + person.rut.gsub('-','').to_s.rjust(9, '0') + code2 + "0000000000000P" + "00000650000       10102011"
        wpfile.puts body
      end
      wpfile.close


      wpDiscount = Wpdiscount.new()
      data = File.open("#{Rails.root}/#{self.cod_wp}_wp_file.txt")
      wpDiscount.discountfile = data
      wpDiscount.workplace_id = self.id
      if wpDiscount.save
        File.delete("#{Rails.root}/#{self.cod_wp}_wp_file.txt")
      end
    else  
      people_ss = self.people

      wpfilertf = File.new("#{self.cod_wp}_wp_file.xls", "w")

      wpfilertf.puts "COLEGIO DE ENFERMERAS DE CHILE A.G."
      wpfilertf.puts " Casilla 9752 - Correo Plaza  de Armas"
      wpfilertf.puts " SANTIAGO"
      wpfilertf.puts " "
      wpfilertf.puts "\tLISTADO DESCUENTOS  MES: #{Time.now.strftime("%m-%Y")}"               
      wpfilertf.puts "\tINSTITUCION :" + self.nombre                
      wpfilertf.puts "\tCODIGO: " + self.cod_wp               

      wpfilertf.puts " "
      wpfilertf.puts " "
      wpfilertf.puts "RUT\tCOD\tNOMBRE DEL  FUNCIONARIO\tMONTO MES"   

      people_ss.each do |person|
        wpfilertf.puts person.rut + "\t" + self.cod_wp + "\t" + person.fullname + "\t6500"
      end
      wpfilertf.puts " \t \t Total:\t" + (people_ss.count * 6500).to_s

      wpfilertf.close
    end    
    
    wpfilertf = File.new("#{self.cod_wp}_wp_file.rtf", "w") 

    wpfilertf.puts "Colegio de enfermeras de Chile A.G."
    wpfilertf.puts "Descuentos colegiadas : " + self.nombre
    wpfilertf.puts " "
    wpfilertf.puts "RUT_FUNC  Nombre_colegiada  Monto_dcto"   

    people_ss.each do |person|
      wpfilertf.puts person.rut + ' ' + person.fullname + ' $6.500.-'
    end
    wpfilertf.close
  end 

  def people_for_ss
    if self.serv_salud == 'SI'
      Person.where(workplace_id: Workplace.select(:id).where(cod_serv_salud: self.cod_serv_salud))
    else
      self.people
    end  
  end

    def self.import_email(file)
      CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
        wp = Workplace.where(cod_wp: rowHash["cod_wp"]).first
        
        if wp.present?
          if rowHash["email1"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email1"]
            wpemail.save
          end
          if rowHash["email2"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email2"]
            wpemail.save
          end
          if rowHash["email3"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email3"]
            wpemail.save
          end
          if rowHash["email4"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email4"]
            wpemail.save
          end
          if rowHash["email5"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email"]
            wpemail.save
          end
        end  
      end
  end

   def self.import_emailss(file)
      CSV.foreach(file.path, col_sep: ';', headers: true, encoding: "ISO-8859-1" ) do |row|
      rowHash = row.to_hash
      puts "*********************"
      puts rowHash
      puts "*********************"

        wp = Workplace.where(cod_serv_salud: rowHash["cod_serv"], serv_salud: "SI").first
        
        if wp.present?
          if rowHash["email1"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email1"]
            wpemail.save
          end
          if rowHash["email2"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email2"]
            wpemail.save
          end
          if rowHash["email3"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email3"]
            wpemail.save
          end
          if rowHash["email4"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email4"]
            wpemail.save
          end
          if rowHash["email5"].present?
            wpemail = Wpemail.new
            wpemail.workplace_id = wp.id
            wpemail.email = rowHash["email5"]
            wpemail.save
          end
        end  
      end
  end

end
