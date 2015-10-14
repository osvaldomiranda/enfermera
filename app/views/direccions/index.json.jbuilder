json.array!(@direccions) do |direccion|
  json.extract! direccion, :id, :tipo, :calle_num_depto, :comuna, :ciudad, :telefono, :celular, :codigo_postal, :tipo_vivienda, :dividendo_arriendo, :casilla, :num_correo, :ciudad, :person_id
  json.url direccion_url(direccion, format: :json)
end
