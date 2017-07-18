# encoding: utf-8
class Api::V1::InscriptionsController < ApplicationController
  protect_from_forgery exception: :change_state
  def change_state

    inscriptions = Inscription.where(estado: 'SOLICITADA').where('created_at <= ?', 10.days.ago)
    inscriptions.each do |inscription| 
      
      inscription.estado = 'APROBADA'
      inscription.user_id = 1
      unless inscription.password.present?
        inscription.password = inscription.rut
      end  

      if inscription.save
        inscription.create_person_user
      end
    end
    render :json=> {updated: :true}, :status => :ok
  end
end