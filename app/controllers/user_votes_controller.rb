class UserVotesController < ApplicationController
  before_action :set_user_vote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_votes = UserVote.all
    respond_with(@user_votes)
  end

  def show
    respond_with(@user_vote)
  end

  def new
    @user_vote = UserVote.new
    respond_with(@user_vote)
  end

  def edit
  end

  def create
    @user_vote = UserVote.new(user_vote_params)
    @user_vote.save
    respond_with(@user_vote)
  end

  def update
    @user_vote.update(user_vote_params)
    respond_with(@user_vote)
  end

  def destroy
    @user_vote.destroy
    respond_with(@user_vote)
  end

  private
    def set_user_vote
      @user_vote = UserVote.find(params[:id])
    end

    def user_vote_params
      params.require(:user_vote).permit(:user_id, :vote_id)
    end
end
