class Inscription < ActiveRecord::Base

	include ActiveModel::Validations

	GENDERS = ['Masculino', 'Femenino']

	def self.gender_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    GENDERS.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  NACIONALIDAD      = ['Chilena', 'Extranjero']
  def self.nacionalidad_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    NACIONALIDAD.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  TIPOCONTRATO      = ['Planta', 'Palzo Fijo', 'Honorarios']
  def self.tipocontrato_options_for_select
    #GENDERS.to_enum.with_index(0).to_a
    TIPOCONTRATO.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 

  #Validamos en una expresion regular nuestro email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { :with => VALID_EMAIL_REGEX , message: "El formato del correo es invalido" }

  # Validamos que el email sea unico
  validates :email, uniqueness: {case_sensitive: false ,message: "email se encuentra registrado"}

	#validates_with RutFormatValidator, field: [:rut]
  validates :rut, presence: true, rutFormat: true

  # Validamos que el telefono solo sea numerico
  validates :telefono, numericality: { only_integer: true }

    # Validamos que el celular solo sea numerico
  validates :celular, numericality: { only_integer: true }



end

	