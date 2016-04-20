class RegionalManagerController < ApplicationController
  def index
  	@person_workplace = Person.group(:lugar_trabajo).count
  end
end
