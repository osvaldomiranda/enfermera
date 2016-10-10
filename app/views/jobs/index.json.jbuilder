json.array!(@jobs) do |job|
  json.extract! job, :id, :titulo, :descripcion, :contacto, :estado
  json.url job_url(job, format: :json)
end
