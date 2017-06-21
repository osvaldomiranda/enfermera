class PersonMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_discount(workplace_id)
    begin

      @workplace = Workplace.find(workplace_id)

      @url  = 'http://www.colegioenfermerasdechile.cl'

      # fileExtension = File.extname("#{Rails.root}/public#{@reserva.deposito_url}")
      # attachments["deposito#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.deposito_url}")

      # if @reserva.preaprob_url.present?
      #   fileExtension = File.extname("#{Rails.root}/public#{@reserva.preaprob_url}")
      #   attachments["preaprobacion#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.preaprob_url}")
      # end  

      emails = ["osvaldo.omiranda@gmail.com" ]

      mail(to:emails ,subject: "Prueba de Envio", from:  "colegioenfermeras@gmail.com")

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
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

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
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

  def send_news(email)
    begin

      @user = User.where(email: email).first

      @url  = 'http://www.colegioenfermerasdechile.cl'

      emails = [@user.email]

      mail(to: emails ,subject: "Curso liderazgo y gestión de equipos", from:  "colegioenfermeras@gmail.com")

    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end

end
