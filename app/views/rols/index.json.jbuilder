json.array!(@rols) do |rol|
  json.extract! rol, :id, :nombre, :user_id, :region
  json.url rol_url(rol, format: :json)
end
