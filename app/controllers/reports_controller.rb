class ReportsController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @offices = Office.all
    @selected_enero = DateTime.parse("01/01/2016")
    @selected_febrero = DateTime.parse("01/02/2016")
    @selected_marzo = DateTime.parse("01/03/2016")
    @selected_abril = DateTime.parse("01/04/2016")
    @selected_mayo = DateTime.parse("01/05/2016")
    @selected_junio = DateTime.parse("01/06/2016")
    @selected_julio = DateTime.parse("01/07/2016")
    @selected_agosto = DateTime.parse("01/08/2016")
    @selected_septiembre = DateTime.parse("01/09/2016")
    @selected_octubre = DateTime.parse("01/10/2016")
    @selected_noviembre = DateTime.parse("01/11/2016")
    @selected_diciembre = DateTime.parse("01/12/2016")  
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
