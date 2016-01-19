class AdminworckplaceController < ApplicationController
  
  respond_to :html
  def index
  end

  def wppayregister
  	@income = Income.new
    respond_modal_with(@income)
  end	

  def wppay
  end
end
