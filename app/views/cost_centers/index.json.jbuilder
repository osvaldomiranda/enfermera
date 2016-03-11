json.array!(@cost_centers) do |cost_center|
  json.extract! cost_center, :id, :codigo, :nombre
  json.url cost_center_url(cost_center, format: :json)
end
