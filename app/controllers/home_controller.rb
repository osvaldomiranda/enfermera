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
      @office = Office.all

      @publication_news = Publication.where(tipo: 'NOTICIA').where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @publication_yotecuido = Publication.where(tipo: 'YO_TE_CUIDO').where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @publication_eventos = Publication.where(tipo: 'EVENTO').where(estado:'VISIBLE').order('created_at DESC').limit(3)
      @video = Video.last
      
    end  
  end

  def porque
  end
  
  def beneficios
  end

  def obligaciones
  end

  def estatutos
  end

  def reglamento
  end

end
