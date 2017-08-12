class SenddiscountController < ApplicationController
  before_filter :authenticate_user!    
  def index
    @regional = params[:regional] || nil
    @publico = params[:publico] || nil
    @page = params[:page] || 1
    
    if @regional.present?
      @workplaces = Workplace.where(office_id: @regional).order(created_at: :desc).page(params[:page]).per_page(20)  
    else
      if current_user.role?(:national_admin) 
        @workplaces = Workplace.all.order(created_at: :desc).page(params[:page]).per_page(20)
      else
        @workplaces = Workplace.where(office_id: current_user.office.id).order(created_at: :desc).page(params[:page]).per_page(20)
      end    
    end
    
    if @publico.present?
      if @publico == 'SI'
        @workplaces = @workplaces.publicos('SI')
      else
        @workplaces = @workplaces.privados('SI')
      end
    end
  end

  def people
    @page = params[:page] || 1
    @workplace = Workplace.find(params[:id])
  end

  def sendemail
    @workplace = Workplace.find(params[:id])
    @workplace.create_file
    PersonMailer.send_discount(params[:id]).deliver
  end

  def sendretrieve
    PersonMailer.send_retrieve(params[:id]).deliver
  end
end
