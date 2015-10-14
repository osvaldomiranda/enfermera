json.array!(@deuda_directa) do |deuda_directum|
  json.extract! deuda_directum, :id, :tipo, :institucion, :cupo_aprobado, :deuda_vigente, :pago_mensual, :vencimineto, :person_id
  json.url deuda_directum_url(deuda_directum, format: :json)
end
