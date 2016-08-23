json.array!(@votes) do |vote|
  json.extract! vote, :id, :fecha, :votacion, :descripcion, :inicio, :termino, :estado
  json.url vote_url(vote, format: :json)
end
