class RolsController < ApplicationController
  before_action :set_rol, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @rols = Rol.all
    respond_with(@rols)
  end

  def show
    respond_with(@rol)
  end

  def new
    @rol = Rol.new
    respond_with(@rol)
  end

  def edit
  end

  def create
    @rol = Rol.new(rol_params)
    @rol.save
    respond_with(@rol)
  end

  def update
    @rol.update(rol_params)
    respond_with(@rol)
  end

  def destroy
    @rol.destroy
    respond_with(@rol)
  end

  private
    def set_rol
      @rol = Rol.find(params[:id])
    end

    def rol_params
      params.require(:rol).permit(:nombre, :user_id, :region)
    end
end
