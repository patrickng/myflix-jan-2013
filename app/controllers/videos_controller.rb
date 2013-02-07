class VideosController < ApplicationController
  before_filter :require_user
  
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = Video.find(params[:id]).reviews.order('created_at DESC')
    @average_rating = Video.find(params[:id]).reviews.average(:rating)
  end

  def search
    @results = Video.search_by_title(params[:search])
  end
end