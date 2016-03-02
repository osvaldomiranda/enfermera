class AdmincolegiadaController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @colegiadas = Person.all
  end

  def superintendencia
    @colegiadas = Person.all
  end
end
