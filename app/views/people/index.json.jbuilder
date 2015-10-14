json.array!(@people) do |person|
  json.extract! person, :id, :email, :rut, :first_name, :last_name, :gender, :nationality, :economic_activity, :education, :origin_country, :resident_country, :profession, :dependents, :university, :number_of_children, :marital_status, :matrimonial_regime, :date_birth
  json.url person_url(person, format: :json)
end
