json.array!(@vows) do |vow|
  json.extract! vow, :id, :token, :candidate_id, :position_id, :vote_id, :workplace_id
  json.url vow_url(vow, format: :json)
end
