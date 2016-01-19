class AdmincolegiadaController < ApplicationController
  def index
  	@colegiadas = Person.all
  	
  end
end
