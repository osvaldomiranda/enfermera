json.array!(@user_alow_votes) do |user_alow_vote|
  json.extract! user_alow_vote, :id, :user_id, :vote_id
  json.url user_alow_vote_url(user_alow_vote, format: :json)
end
