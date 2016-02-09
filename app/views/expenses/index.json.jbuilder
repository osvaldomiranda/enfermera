json.array!(@expenses) do |expense|
  json.extract! expense, :id, :fecha, :monto, :tipo, :document, :descripcion, :mediopago, :office_id, :user_id_id, :estado
  json.url expense_url(expense, format: :json)
end
