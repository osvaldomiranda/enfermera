json.array!(@spouses) do |spouse|
  json.extract! spouse, :id, :rut, :first_name, :last_name, :gender, :nationality, :economic_activity, :education, :origin_country, :resident_country, :profession, :dependents, :university, :number_of_children, :date_birth, :person_id
  json.url spouse_url(spouse, format: :json)
end
