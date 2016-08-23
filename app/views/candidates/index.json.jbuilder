json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :candidato, :position_id, :vote_id
  json.url candidate_url(candidate, format: :json)
end
