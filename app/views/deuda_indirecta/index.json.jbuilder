json.array!(@deuda_indirecta) do |deuda_indirectum|
  json.extract! deuda_indirectum, :id, :tipo, :institucion, :deuda_vigente, :razon_social, :rut, :person_id
  json.url deuda_indirectum_url(deuda_indirectum, format: :json)
end
