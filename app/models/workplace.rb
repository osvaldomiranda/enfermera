class Workplace < ActiveRecord::Base
	has_many :wpdocument, dependent: :destroy
end
