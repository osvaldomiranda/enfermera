# encoding: utf-8
class Api::V1::FeeController < ApplicationController
  protect_from_forgery exception: :iscollegiate


  def update_mescuota
  	Fee.where.not(mes_cuota:nil).map { |f| f.mescuota_todate}

  	render :json=> {updated: :true}, :status => :ok
  end