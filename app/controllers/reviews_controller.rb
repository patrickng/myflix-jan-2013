class ReviewsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(params[:review])
    @review.user = current_user
    if @review.save
      redirect_to video_path(@video)
    else
      render "videos/show"
    end
  end
end
