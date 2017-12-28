class NewsController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @blogs = Blog.all
  end
end
