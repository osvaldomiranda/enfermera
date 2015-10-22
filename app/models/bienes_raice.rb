class BienesRaice < ActiveRecord::Base
  belongs_to :person

  TIPOBIEN=['Casa','Departamento']
  def self.tipobien_options_for_select
    #TIPOBIEN.to_enum.with_index(0).to_a
    TIPOBIEN.each.map { |t| [t, t.upcase.gsub(' ', '_')] }
  end 
end
