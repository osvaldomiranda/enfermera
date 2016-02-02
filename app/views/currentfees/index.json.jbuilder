json.array!(@currentfees) do |currentfee|
  json.extract! currentfee, :id, :valor
  json.url currentfee_url(currentfee, format: :json)
end
