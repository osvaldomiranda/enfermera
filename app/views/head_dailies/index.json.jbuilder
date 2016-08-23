json.array!(@head_dailies) do |head_daily|
  json.extract! head_daily, :id, :numero, :user_id
  json.url head_daily_url(head_daily, format: :json)
end
