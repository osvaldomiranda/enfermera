class Vote < ActiveRecord::Base
  has_many :candidates
  has_many :positions
  has_many :uservotes 
  has_many :vows

  
end
