json.array!(@wpemails) do |wpemail|
  json.extract! wpemail, :id, :email, :workplace_id
  json.url wpemail_url(wpemail, format: :json)
end
