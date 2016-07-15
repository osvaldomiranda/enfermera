class ReportsController < ApplicationController
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
end
