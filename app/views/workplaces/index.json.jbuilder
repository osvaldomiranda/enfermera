json.array!(@workplaces) do |workplace|
  json.extract! workplace, :id, :nombre, :ciudad, :region
  json.url workplace_url(workplace, format: :json)
end
