json.array!(@officeaccounts) do |officeaccount|
  json.extract! officeaccount, :id, :fecha, :tipo, :monto, :codigo, :account, :user_id, :office_id, :income_id, :expense_id
  json.url officeaccount_url(officeaccount, format: :json)
end
