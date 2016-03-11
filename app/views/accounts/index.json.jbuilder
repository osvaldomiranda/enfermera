json.array!(@accounts) do |account|
  json.extract! account, :id, :codigo, :nombre
  json.url account_url(account, format: :json)
end
