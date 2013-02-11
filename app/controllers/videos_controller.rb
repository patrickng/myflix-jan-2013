class VideosController < ApplicationController
  before_filter :require_user
  
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews.order('created_at DESC')
    @review = Review.new
  end

  def search
    @results = Video.search_by_title(params[:search])
  end
end