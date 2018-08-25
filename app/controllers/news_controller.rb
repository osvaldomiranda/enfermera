class NewsController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @blogs = Blog.order(created_at: :desc)
  end
end
