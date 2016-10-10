json.array!(@videos) do |video|
  json.extract! video, :id, :titulo, :alojamiento, :estado
  json.url video_url(video, format: :json)
end
