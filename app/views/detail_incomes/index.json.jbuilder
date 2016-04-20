json.array!(@detail_incomes) do |detail_income|
  json.extract! detail_income, :id, :pcontable, :fcontable, :tipo_comprobante, :mescuota, :detalle, :debe, :haber, :obeservacion, :account_id, :workplace_id, :cost_center_id, :income_id
  json.url detail_income_url(detail_income, format: :json)
end
