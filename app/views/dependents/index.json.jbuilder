json.array!(@dependents) do |dependent|
  json.extract! dependent, :id, :empleador, :rut_empleador, :giro_empresa, :direccion_empresa, :tipo_contrato, :cargo, :fecha_ingreso, :fecha_ingreso_anterior, :fecha_termino_anterior, :person_id
  json.url dependent_url(dependent, format: :json)
end
