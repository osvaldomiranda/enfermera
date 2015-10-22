class DeudaIndirectum < ActiveRecord::Base
  belongs_to :person

  validates :rut, :rut_format => true

end
