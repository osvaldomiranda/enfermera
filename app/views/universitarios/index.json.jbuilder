json.array!(@universitarios) do |universitario|
  json.extract! universitario, :id, :email, :universidad, :carrera, :encurso, :renta_familiar, :nombre_padre, :rut_padre, :person_id
  json.url universitario_url(universitario, format: :json)
end
