json.array!(@detail_expenses) do |detail_expense|
  json.extract! detail_expense, :id, :numcomprobante, :debe, :haber, :paguesea, :por, :observacion, :account_id, :cost_center_id, :expense_id
  json.url detail_expense_url(detail_expense, format: :json)
end
