json.array!(@offices) do |office|
  json.extract! office, :id, :nombre, :region, :ciudad, :email, :contacto
  json.url office_url(office, format: :json)
end
