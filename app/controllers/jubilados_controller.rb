class JubiladosController < ApplicationController
  before_action :set_jubilado, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @jubilados = Jubilado.all
    respond_with(@jubilados)
  end

  def show
    respond_with(@jubilado)
  end

  def new
    @jubilado = Jubilado.new
    respond_with(@jubilado)
  end

  def edit
  end

  def create
    @jubilado = Jubilado.new(jubilado_params)
    @jubilado.save
    respond_with(@jubilado)
  end

  def update
    @jubilado.update(jubilado_params)
    respond_with(@jubilado)
  end

  def destroy
    @jubilado.destroy
    respond_with(@jubilado)
  end

  private
    def set_jubilado
      @jubilado = Jubilado.find(params[:id])
    end

    def jubilado_params
      params.require(:jubilado).permit(:ultimo_empleador, :institucion_pagadora, :afp, :cia_seguro, :person_id)
    end
end
