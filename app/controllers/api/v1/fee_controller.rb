# encoding: utf-8
class Api::V1::FeeController < ApplicationController
  protect_from_forgery exception: :iscollegiate


  def update_mescuota
  	Fee.where(mescuota: nil).where.not(mes_cuota: nil).limit(5000).map {|f| f.mescuota = Date.parse("01-#{f.mes_cuota}"); f.save}

  	Daily.where(estado: nil).update_all(estado: 'ACTIVO')

  	render :json=> {updated: :true}, :status => :ok
  end
end  