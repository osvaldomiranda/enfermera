class HomeController < ApplicationController
  # before_filter :authenticate_user!
  def index
    if current_user.present?
      if current_user.sign_in_count < 2
        redirect_to welcome_index_path
      else  
        redirect_to dashboard_index_path
      end  
    else  
      @scientific_societies =  ScientificSociety.all
      @national_councils = NationalCouncil.all.order('prioridad ASC')
      @office = Office.order(:id)

      @publication_news = Publication.where(tipo: 'NOTICIA').scheduled().where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @publication_yotecuido = Publication.where(tipo: 'YO_TE_CUIDO').scheduled().where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @publication_eventos = Publication.where(tipo: 'EVENTO').scheduled().where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @video = Video.last
    end  
  end

  def porque
  end

  # Publication.where(fecha_desde:nil).update_all(fecha_desde: DateTime.now.to_date - 1.days)
  # Publication.update_all(fecha_hasta: Date.strptime('31-12-2099', '%d-%m-%Y') )
  
  def beneficios
  end

  def obligaciones
  end
  
  def vademecum
  end

  def estatutos
    path = "public/estatuto.pdf"
    send_file( path,
    :disposition => 'inline',
    :type => 'application/pdf',
    :x_sendfile => true )
  end

  def reglamento
    path = "public/reglamento.pdf"
    send_file( path,
    :disposition => 'inline',
    :type => 'application/pdf',
    :x_sendfile => true )
  end

end
