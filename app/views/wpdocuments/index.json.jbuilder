json.array!(@wpdocuments) do |wpdocument|
  json.extract! wpdocument, :id, :nombre, :tipo, :documento, :workplace_id
  json.url wpdocument_url(wpdocument, format: :json)
end
