class MagazinesController < ApplicationController
  before_action :set_magazine, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @magazines = Magazine.order(fecha: :desc)
    respond_with(@magazines)
  end

  def show
    respond_with(@magazine)
  end

  def new
    @magazine = Magazine.new
    respond_with(@magazine)
  end

  def edit
  end

  def create
    @magazine = Magazine.new
    @magazine.fecha       = Date.parse(magazine_params[:fecha])
    @magazine.titulo      = magazine_params[:titulo]
    @magazine.descripcion = magazine_params[:descripcion]
    @magazine.portada     = magazine_params[:portada]
    @magazine.documento   = magazine_params[:documento]
    @magazine.save
    respond_with(@magazine)
  end

  def update
    @magazine.update(magazine_params)
    respond_with(@magazine)
  end

  def destroy
    @magazine.destroy
    respond_with(@magazine)
  end

  private
    def set_magazine
      @magazine = Magazine.find(params[:id])
    end

    def magazine_params
      params.require(:magazine).permit(:titulo, :descripcion, :portada, :documento, :fecha)
    end
end
