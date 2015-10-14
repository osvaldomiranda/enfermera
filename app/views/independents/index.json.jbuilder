json.array!(@independents) do |independent|
  json.extract! independent, :id, :tipo_rentista, :tipo_actividad, :giro_actividad, :fecha_inicio_rubro, :fecha_inicio_actividad, :nombre_empleador_anterior, :cargo, :antiguedad, :person_id
  json.url independent_url(independent, format: :json)
end
