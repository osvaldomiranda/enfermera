json.array!(@regions) do |region|
  json.extract! region, :id, :codigo, :nombre
  json.url region_url(region, format: :json)
end
