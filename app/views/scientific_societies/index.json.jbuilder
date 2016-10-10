json.array!(@scientific_societies) do |scientific_society|
  json.extract! scientific_society, :id, :nombre, :descripcion, :logo, :direccion, :telefono, :contacto, :web_url
  json.url scientific_society_url(scientific_society, format: :json)
end
