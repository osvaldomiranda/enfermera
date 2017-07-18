json.array!(@wpdiscounts) do |wpdiscount|
  json.extract! wpdiscount, :id, :discountfile, :email, :workplace_id
  json.url wpdiscount_url(wpdiscount, format: :json)
end
