json.array!(@incomes) do |income|
  json.extract! income, :id, :fecha, :monto, :tipo, :document, :banco, :mediopago, :person_id, :workplace_id, :user_id
  json.url income_url(income, format: :json)
end
