json.array!(@dailies) do |daily|
  json.extract! daily, :id, :numero, :fecha, :cost_center_id, :account_id, :debe, :haber, :numdocumento, :detalle, :paguesea, :por, :tipo, :office_id, :income_id, :expense_id
  json.url daily_url(daily, format: :json)
end
