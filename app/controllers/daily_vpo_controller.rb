class DailyVpoController < ApplicationController
  before_filter :authenticate_user! 
 
  respond_to :html

  def index
    @tipo = params[:tipo] || nil
    @origen = params[:origen] || nil
    @estado = params[:estado] || nil

    @page = params[:page] || 1


    if params["/head_dailies"].present?
      @numero = params["/head_dailies"][:numero] || nil
      if params[:page].present?
        @page = params[:page]
      else  
        @page = params["/head_dailies"][:page] || 1
      end  
    end

    @page = nil if @page == ""

    @head_dailies = HeadDaily.with_origen(@origen).with_estado(@estado).with_tipo(@tipo).with_numero(@numero).where.not(folio_office:nil).order(numero: :desc).page(@page).per_page(20) 
    respond_with(@head_dailies)
  end
  
end
