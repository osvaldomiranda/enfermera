class ReportsController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @origen = params[:origen]

    office = params[:office]


    if params[:office].present?
      @offices = Office.where(nombre:params[:office])
    else  
      @offices = nil
    end  
    @office = params[:office] || nil

    @selected_enero = DateTime.parse("01/01/#{@origen}")
    @selected_febrero = DateTime.parse("01/02/#{@origen}")
    @selected_marzo = DateTime.parse("01/03/#{@origen}")
    @selected_abril = DateTime.parse("01/04/#{@origen}")
    @selected_mayo = DateTime.parse("01/05/#{@origen}")
    @selected_junio = DateTime.parse("01/06/#{@origen}")
    @selected_julio = DateTime.parse("01/07/#{@origen}")
    @selected_agosto = DateTime.parse("01/08/#{@origen}")
    @selected_septiembre = DateTime.parse("01/09/#{@origen}")
    @selected_octubre = DateTime.parse("01/10/#{@origen}")
    @selected_noviembre = DateTime.parse("01/11/#{@origen}")
    @selected_diciembre = DateTime.parse("01/12/#{@origen}")  
  end

  def gastos_cc
    @gastos_cc = Daily.where(tipo: "EGRESO").group(:cost_center_id).sum(:debe)
    @gastos_grafico = @gastos_cc.map {|k, v| [ k.present? ? CostCenter.find(k).nombre : "Sin CC", v] }
  end

  def gastos_cta_cc
    @cost_center = CostCenter.find(params[:id]).nombre
    @gastos_cuenta = Daily.where(tipo: "EGRESO", cost_center_id: params[:id]).group(:account_id).sum(:debe)
    @gastos_grafico = @gastos_cuenta.map {|k, v| [ k.present? ? Account.find(k).nombre : "sin cta", v] }
  end

  def detalle_diario
    dailies = Daily.where(account_id: params[:id])
    @head_dailies = HeadDaily.where(numero: dailies.uniq.pluck(:numero))
  end

end
