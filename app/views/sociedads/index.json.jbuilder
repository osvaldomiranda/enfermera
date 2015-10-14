json.array!(@sociedads) do |sociedad|
  json.extract! sociedad, :id, :tipo, :porcentaje, :capital, :nombre, :rut, :person_id
  json.url sociedad_url(sociedad, format: :json)
end
