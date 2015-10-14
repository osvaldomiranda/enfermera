json.array!(@ingresos) do |ingreso|
  json.extract! ingreso, :id, :sueldo_fijo_mes, :sueldo_variable_mes, :arriendo, :vtas_anuales, :declaracion_renta, :honorarios_mes, :cta_cte, :banco, :person_id
  json.url ingreso_url(ingreso, format: :json)
end
