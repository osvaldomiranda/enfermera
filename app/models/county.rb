class County < ActiveRecord::Base
  belongs_to :state


  def self.for_select
    County.order(:name).map{|t| [t.name, t.name.upcase]}
  end 
end
