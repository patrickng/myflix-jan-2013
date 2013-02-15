class ReviewsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    video = Video.find(params[:video_id])
    review = video.reviews.create(params[:review].merge!(user_id: current_user.id))
    if review.save
      redirect_to video
    else
      render "videos/show"
    end
  end

  def edit
    
  end

  def update

  end
end
