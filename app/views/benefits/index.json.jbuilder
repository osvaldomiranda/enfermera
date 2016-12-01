json.array!(@benefits) do |benefit|
  json.extract! benefit, :id, :institucion, :resumen, :imagen, :web, :office_id
  json.url benefit_url(benefit, format: :json)
end
