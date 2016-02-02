class SensomaticaController < ApplicationController
  require 'rest-client'
    
  def index
    @temp = 'hola'
  end

  def calltemp
  	
    @temp = RestClient.get 'http://192.168.0.22:3000/temp'

    render 'index'
  end
end
