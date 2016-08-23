class CandidatesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @candidates = Candidate.all
    respond_with(@candidates)
  end

  def show
    respond_with(@candidate)
  end

  def new
    @candidate = Candidate.new
    respond_with(@candidate)
  end

  def edit
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @candidate.save
    respond_with(@candidate)
  end

  def update
    @candidate.update(candidate_params)
    respond_with(@candidate)
  end

  def destroy
    @candidate.destroy
    respond_with(@candidate)
  end

  private
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def candidate_params
      params.require(:candidate).permit(:candidato, :position_id, :vote_id)
    end
end
