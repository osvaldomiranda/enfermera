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

      emails = ["osvaldo.omiranda@gmail.com", "tesoreria@colegiodeenfermeras.cl" ]

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
      @person = Person.find_by_rut(rut)

      @url  = 'http://www.colegioenfermerasdechile.cl'

      # fileExtension = File.extname("#{Rails.root}/public#{@reserva.deposito_url}")
      # attachments["deposito#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.deposito_url}")

      # if @reserva.preaprob_url.present?
      #   fileExtension = File.extname("#{Rails.root}/public#{@reserva.preaprob_url}")
      #   attachments["preaprobacion#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.preaprob_url}")
      # end  

      emails = [@person.email]

      mail(to:emails ,subject: "Sistema Colegio de Enfermeras de Chile", from:  "colegioenfermeras@gmail.com", cco: "osvaldo.omiranda@gmail.com",)

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  
end
