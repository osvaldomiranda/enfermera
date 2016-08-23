class RegionalManagerController < ApplicationController
	before_filter :authenticate_user! 
  def index
  	@person_workplace = Person.group(:lugar_trabajo).count
  end
end
