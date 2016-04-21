class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    redirect_to dashboard_index_path
  end
end
