class SensomaticaController < ApplicationController
  require 'rest-client'
    
  def index
    @temp = RestClient.get 'http://192.168.1.38:3000/'
  end

  def calltemp
  	
    @temp = RestClient.get 'http://192.168.1.38:3000/temp'

    render 'index'
  end
end
