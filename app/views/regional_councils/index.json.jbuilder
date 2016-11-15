json.array!(@regional_councils) do |regional_council|
  json.extract! regional_council, :id, :nombre, :cargo, :email, :fono, :office_id, :person_id
  json.url regional_council_url(regional_council, format: :json)
end
