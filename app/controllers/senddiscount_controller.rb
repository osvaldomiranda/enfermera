class SenddiscountController < ApplicationController
  before_filter :authenticate_user!    
  def index
    @regional = params[:regional] || nil
    
    if @regional.present?
      @workplaces = Workplace.where(office_id: @regional).order(created_at: :desc).page(params[:page]).per_page(20)  
    else
      @workplaces = Workplace.all.order(created_at: :desc).page(params[:page]).per_page(20)  
    end
  end

  def sendemail
    PersonMailer.send_discount(params[:id]).deliver
  end

  def sendretrieve
    PersonMailer.send_retrieve(params[:id]).deliver
  end
end
