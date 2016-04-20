class AdmincolegiadaController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @colegiadas = Person.all
    @colegiada_ciudad = Person.group(:ciudad).count
  end

  def superintendencia
    @colegiadas = Person.all
  end
end
