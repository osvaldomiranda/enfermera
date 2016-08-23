class VowsController < ApplicationController
  before_action :set_vow, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @vows = Vow.all
    respond_with(@vows)
  end

  def show
    respond_with(@vow)
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
    puts params

    @vow = Vow.new
    @vow.vote_id = vow_params[:vote_id]
    @vow.candidate_id = vow_params[:candidate_id]
    @vow.save
    respond_with(@vow)
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
