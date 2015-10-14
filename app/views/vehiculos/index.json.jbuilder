json.array!(@vehiculos) do |vehiculo|
  json.extract! vehiculo, :id, :tipo, :marca, :modelo, :agno, :patente, :valor_comercia, :prenda_afavor, :person_id
  json.url vehiculo_url(vehiculo, format: :json)
end
