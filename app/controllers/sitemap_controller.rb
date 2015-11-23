class SitemapController < ApplicationController
  respond_to :xml
  def index
    @tags = Tag.order("created_at DESC")
    @jokes = Joke.order("created_at DESC")
  end
end