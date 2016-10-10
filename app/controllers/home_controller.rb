class HomeController < ApplicationController
  # before_filter :authenticate_user!
  def index
    if current_user.present?
      redirect_to dashboard_index_path
    else  
      @scientific_societies =  ScientificSociety.all
      @publication_news = Publication.where(tipo: 'NOTICIA')
      @publication_yotecuido = Publication.where(tipo: 'YOTECUIDO')
    end  
  end
end
