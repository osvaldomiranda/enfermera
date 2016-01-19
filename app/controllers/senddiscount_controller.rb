class SenddiscountController < ApplicationController
  def index
  	@workplaces = Workplace.all
  end

  def sendemail
  end
end
