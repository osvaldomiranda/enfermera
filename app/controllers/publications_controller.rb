class PublicationsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only:[:froala_upload]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :create, :destroy]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tipo = params[:tipo] || nil
    @publications = Publication.where(estado:'VISIBLE').scheduled().with_tipo(@tipo).order('created_at DESC')
    if current_user.present?
      if current_user.role?(:web)
        @publications = Publication.all.order('created_at DESC')
      end
    end  
    respond_with(@publications)
  end

  def show
    respond_with(@publication)
  end

  def new
    @publication = Publication.new
    respond_with(@publication)
  end

  def edit
  end

  def create
    pp = publication_params
    pp[:fecha_desde] = publication_params[:fecha_desde].present? ? Date.strptime(publication_params[:fecha_desde], '%d-%m-%Y') : DateTime.now.to_date  
    pp[:fecha_hasta] = publication_params[:fecha_hasta].present? ? Date.strptime(publication_params[:fecha_hasta], '%d-%m-%Y') : Date.strptime('31-12-2099', '%d-%m-%Y') 

    @publication = Publication.new(pp)
    @publication.save
    respond_with(@publication)
  end

  def update
    pp = publication_params
    pp[:fecha_desde] = publication_params[:fecha_desde].present? ? Date.strptime(publication_params[:fecha_desde], '%d-%m-%Y') : DateTime.now.to_date  
    pp[:fecha_hasta] = publication_params[:fecha_hasta].present? ? Date.strptime(publication_params[:fecha_hasta], '%d-%m-%Y') : Date.strptime('31-12-2099', '%d-%m-%Y') 

    @publication.update(pp)
    respond_with(@publication)
  end

  def destroy
    @publication.destroy
    respond_with(@publication)
  end

  def froala_upload
    uploader = ImageBucket.new
    uploader.image = params[:file]
    uploader.save
    render :json => { status: 'OK', link: uploader.image.url}
    rescue CarrierWave::IntegrityError => e
      render json: { error: e.message }
  end


  private
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def publication_params
      params.require(:publication).permit(:titulo, :texto, :resumen, :imagen, :tipo, :documeto, :estado, :web)
    end
end
