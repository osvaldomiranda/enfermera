class PersonMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_discount(workplace_id)
    begin
      require 'open-uri'
      @workplace = Workplace.find(workplace_id)

      @url  = 'http://www.colegioenfermerasdechile.cl'

      if @workplace.serv_salud == 'SI' 
        open('nomina.txt', 'wb') do |file|
          file << open("#{@workplace.wpdiscounts.last.discountfile_url}").read
        end
        attachments["nomina.txt"] = File.read("#{Rails.root}/nomina.txt")
        attachments["nomina.rtf"] = File.read("#{Rails.root}/#{@workplace.cod_wp}_wp_file.rtf")
      else
        attachments["nomina.xls"] = File.read("#{Rails.root}/#{@workplace.cod_wp}_wp_file.xls")
      end


      emails = ["osvaldo.omiranda@gmail.com", "tesoreria@colegiodeenfermeras.cl", "contabilidad1@colegiodeenfermeras.cl", "contabilidad@colegiodeenfermeras.cl"]


      @workplace.wpemails.each do |wpemail|
        puts "******************"
        puts wpemail.email
        puts "******************"
        emails << wpemail.email
      end  

      mail(to:emails ,subject: "Nomina Descuentos" , from:  "colegioenfermeras@gmail.com")

      File.delete("#{Rails.root}/#{@workplace.cod_wp}_wp_file.xls")
      File.delete("#{Rails.root}/#{@workplace.cod_wp}_wp_file.rtf")

    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  

  def send_retrieve(workplace_id)
    begin

      @workplace = Workplace.find(workplace_id)

      @url  = 'http://www.colegioenfermerasdechile.cl'

      # fileExtension = File.extname("#{Rails.root}/public#{@reserva.deposito_url}")
      # attachments["deposito#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.deposito_url}")

      # if @reserva.preaprob_url.present?
      #   fileExtension = File.extname("#{Rails.root}/public#{@reserva.preaprob_url}")
      #   attachments["preaprobacion#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.preaprob_url}")
      # end  

      emails = ["osvaldo.omiranda@gmail.com","tesoreria@colegiodeenfermeras.cl"]

      mail(to:emails ,subject: "Prueba de Envio", from:  "colegioenfermeras@gmail.com")

    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  

  def send_user(rut)
    begin

      @user = User.find_by_rut(rut)
      @inscription = Inscription.find_by_rut(rut)

      @url  = 'http://www.colegioenfermerasdechile.cl'

      emails = [@inscription.workplace.office.email]

      mail(to: emails ,subject: "Sistema Colegio de Enfermeras de Chile", from:  "colegioenfermeras@gmail.com", cc: "contabilidad1@colegiodeenfermeras.cl" ,bcc: "osvaldo.omiranda@gmail.com")

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  

  def update_user(person, changes)
    begin
      @changes = changes
      @person = person

      @url  = 'http://www.colegioenfermerasdechile.cl'

      emails = ["contabilidad1@colegiodeenfermeras.cl"]

      mail(to:emails ,subject: "Datos cambiados por el Usuario, Sistema Colegio de Enfermeras de Chile", from:  "colegioenfermeras@gmail.com",bcc: "osvaldo.omiranda@gmail.com")

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  

  def pay_user(person, head_daily)
    begin
      @person = person
      @head_daily = head_daily

      @url  = 'http://www.colegioenfermerasdechile.cl'

      emails = ["contabilidad@colegiodeenfermeras.cl"]

      mail(to:emails ,subject: "Cuotas pagadas por el Usuario, Sistema Colegio de Enfermeras de Chile", from:  "colegioenfermeras@gmail.com",bcc: "osvaldo.omiranda@gmail.com")

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  

  def send_news(email)
    # begin

      @user = User.where(email: email).first

      @url  = 'http://www.colegioenfermerasdechile.cl'

      emails = [@user.email]

      # attachments["afiche_diplomados_2018.jpg"] = File.read("#{Rails.root}/afiche_diplomados_2018.jpg")


      mail(to: emails ,subject: "Nuevo Diplomado de Enfermería en Cuidado del Paciente Adulto con Cáncer - ¡Conoce más aquí!")
    # rescue
    #   puts "********* person_mailer **************"
    #   puts "Error  send #{$!}"
    #   puts "***********************"
    # end
  end

end
