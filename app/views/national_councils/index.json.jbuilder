json.array!(@national_councils) do |national_council|
  json.extract! national_council, :id, :nombre, :imagen, :cargo, :curriculum
  json.url national_council_url(national_council, format: :json)
end
