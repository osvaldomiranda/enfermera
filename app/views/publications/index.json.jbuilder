json.array!(@publications) do |publication|
  json.extract! publication, :id, :titulo, :texto, :resumen, :imagen, :tipo, :documeto, :estado
  json.url publication_url(publication, format: :json)
end
