class SenddiscountController < ApplicationController
  def index
  	@workplaces = Workplace.all
  end

  def sendemail
  	PersonMailer.send_discount.deliver
  end
end
