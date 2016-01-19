class AdmincolegiadaController < ApplicationController
  def index
  	@colegiadas = Person.all
  end

  def superintendencia
  	@colegiadas = Person.all
  end
end
