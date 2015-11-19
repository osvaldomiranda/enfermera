json.array!(@persondocuments) do |persondocument|
  json.extract! persondocument, :id, :nombre, :tipo, :documento, :person_id
  json.url persondocument_url(persondocument, format: :json)
end
