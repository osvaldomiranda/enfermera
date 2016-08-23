class Candidate < ActiveRecord::Base
  belongs_to :position
  belongs_to :vote

  def self.candidatos_options_for_select(vote)
    #GENDERS.to_enum.with_index(0).to_a
    Candidate.where(vote_id: vote).map {|c| [c.candidato, c.id]}
  end 

end
