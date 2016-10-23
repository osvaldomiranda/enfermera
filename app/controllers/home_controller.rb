class HomeController < ApplicationController
  # before_filter :authenticate_user!
  def index
    if current_user.present?
      redirect_to dashboard_index_path
    else  
      @scientific_societies =  ScientificSociety.all
      @national_councils = NationalCouncil.all
      @publication_news = Publication.where(tipo: 'NOTICIA')
      @publication_yotecuido = Publication.where(tipo: 'YO_TE_CUIDO')
      @publication_eventos = Publication.where(tipo: 'EVENTO')
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
