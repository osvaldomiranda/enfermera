class Inscription < ActiveRecord::Base

	GENDERS = ['Masculino', 'Femenino']

	def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

end
