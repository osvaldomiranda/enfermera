class RegionalCouncil < ActiveRecord::Base
  belongs_to :office
  belongs_to :person
end
