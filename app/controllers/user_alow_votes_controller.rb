class UserAlowVotesController < ApplicationController
  before_action :set_user_alow_vote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_alow_votes = UserAlowVote.all
    respond_with(@user_alow_votes)
  end

  def show
    respond_with(@user_alow_vote)
  end

  def new
    @user_alow_vote = UserAlowVote.new
    respond_with(@user_alow_vote)
  end

  def edit
  end

  def create
    @user_alow_vote = UserAlowVote.new(user_alow_vote_params)
    @user_alow_vote.save
    respond_with(@user_alow_vote)
  end

  def update
    @user_alow_vote.update(user_alow_vote_params)
    respond_with(@user_alow_vote)
  end

  def destroy
    @user_alow_vote.destroy
    respond_with(@user_alow_vote)
  end

  private
    def set_user_alow_vote
      @user_alow_vote = UserAlowVote.find(params[:id])
    end

    def user_alow_vote_params
      params.require(:user_alow_vote).permit(:user_id, :vote_id)
    end
end
