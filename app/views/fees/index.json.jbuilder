json.array!(@fees) do |fee|
  json.extract! fee, :id, :rut, :email, :fecha_pago, :mes, :monto, :person_id
  json.url fee_url(fee, format: :json)
end
