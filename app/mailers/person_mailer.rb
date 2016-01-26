class PersonMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_discount
    begin


      @url  = 'http://www.colegioenfermerasdechile.cl'

      # fileExtension = File.extname("#{Rails.root}/public#{@reserva.deposito_url}")
      # attachments["deposito#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.deposito_url}")

      # if @reserva.preaprob_url.present?
      #   fileExtension = File.extname("#{Rails.root}/public#{@reserva.preaprob_url}")
      #   attachments["preaprobacion#{fileExtension}"] = File.read("#{Rails.root}/public#{@reserva.preaprob_url}")
      # end  

      emails = ["osvaldo.omiranda@gmail.com"]

      mail(to:emails ,subject: "Prueba de Envio", from:  "colegioenfermeras@gmail.com")

# cc: "reservas@capitalizarme.com", bcc: "logistica@capitalizarme.com" 
    rescue
      puts "********* person_mailer **************"
      puts "Error  send #{$!}"
      puts "***********************"
    end
  end  
end
