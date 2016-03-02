class NewsController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @blogs = Blog.where(estado: "VISIBLE")
  end
end
