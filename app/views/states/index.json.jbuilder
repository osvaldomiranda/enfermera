json.array!(@states) do |state|
  json.extract! state, :id, :name, :city
  json.url state_url(state, format: :json)
end
