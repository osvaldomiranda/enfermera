class Spouse < ActiveRecord::Base
  belongs_to :person

  validates :rut, :rut_format => true

  GENDERS      = ['Masculino', 'Femenino']
  EDUCATION    = ['Basica','Media','Tecnica', 'Universitaria']
  COUNTRY      = ['Chile', 'Otro'] 

  def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  def self.education_options_for_select
    #EDUCATION.to_enum.with_index(0).to_a
    EDUCATION.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end
  def self.country_options_for_select
    #MRITALREGIME.to_enum.with_index(0).to_a
    COUNTRY.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end
end
