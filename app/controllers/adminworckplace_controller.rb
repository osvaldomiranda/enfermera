class AdminworckplaceController < ApplicationController
  
  respond_to :html
  def index
  end

  def wppayregister
  	@income = Income.new
    respond_with(@income)
  end	

  def wppay
  	@income = Income.new
    respond_with(@income)
  end
end
