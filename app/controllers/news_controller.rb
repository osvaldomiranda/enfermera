class NewsController < ApplicationController
  def index
    @blogs = Blog.where(estado: "VISIBLE")
  end
end
