json.array!(@bienes_raices) do |bienes_raice|
  json.extract! bienes_raice, :id, :tipo, :direccion, :valor_comercial, :rol, :hipoteca_banco, :person_id
  json.url bienes_raice_url(bienes_raice, format: :json)
end
