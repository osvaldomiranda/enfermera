json.array!(@magazines) do |magazine|
  json.extract! magazine, :id, :titulo, :descripcion, :portada, :documento
  json.url magazine_url(magazine, format: :json)
end
