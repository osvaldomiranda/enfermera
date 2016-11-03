class AdmincolegiadaController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @colegiadas = Person.all
    @colegiada_ciudad = Person.group(:ciudad).count
  end

  def superintendencia
    @colegiadas = Person.order('nro_registro DESC')
  end

  def toxls
    require 'csv'
    @colegiadas = Person.order('nro_registro DESC')
    respond_to do |format|
      format.xls 
    end
  end
end
