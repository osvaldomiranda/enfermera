
class VowsController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_vow, only: [:show, :edit, :update, :destroy, :showtopdf]

  respond_to :html

  def index
    @vote = params[:vote] || nil
    @candidate = params[:candidate] || nil

    @vows = Vow.with_vote(@vote).with_candidate(@candidate)
    respond_with(@vows)
  end

  def show    
    @vowuser = UserVote.find_by_token(@vow.token)
    respond_with(@vow)
  end

  def showtopdf
    vowuser = UserVote.find_by_token(@vow.token)
    render pdf: "pdf",  orientation: 'Landscape'
  end

  def new
    @vote_id = params[:vote]
    @vote = Vote.find(@vote_id )
    @votacion_votos = @vote.vows.group(:candidate).count
    @votacion_votos = @votacion_votos.map {|k, v| [ k.candidato, v] }

    @vow = Vow.new
    respond_with(@vow)
  end

  def edit
  end

  def create
    @vow = Vow.new
    if !current_user.vow?(vow_params[:vote_id])
      @vow.vote_id = vow_params[:vote_id]
      @vow.candidate_id = vow_params[:candidate_id]
      if @vow.save
        @vow.create_user_vote(current_user)  
      end
      respond_with(@vow)
    else
      respond_with(@vow)  
    end
  end

  def update
    @vow.update(vow_params)
    respond_with(@vow)
  end

  def destroy
    @vow.destroy
    respond_with(@vow)
  end

  private
    def set_vow
      @vow = Vow.find(params[:id])
    end

    def vow_params
      params.require(:vow).permit(:token, :candidate_id, :position_id, :vote_id, :workplace_id)
    end
end
