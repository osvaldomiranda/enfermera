json.array!(@previousjobs) do |previousjob|
  json.extract! previousjob, :id, :establecimiento, :ciudad, :region, :desde, :hasta, :person_id
  json.url previousjob_url(previousjob, format: :json)
end
