class Wpemail < ActiveRecord::Base
  belongs_to :workplace

  scope :workplace, -> workplace { where(workplace_id: workplace) if workplace.present?}
end
