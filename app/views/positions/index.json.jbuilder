json.array!(@positions) do |position|
  json.extract! position, :id, :cargo, :vote_id
  json.url position_url(position, format: :json)
end
