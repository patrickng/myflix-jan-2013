class QueueItem < ActiveRecord::Base
  # attr_accessible :category, :instant_queue_id, :video_rating, :video_title

  belongs_to :user
  belongs_to :video

  def user_rating
    review = video.reviews.where(user_id: user_id).first
    review.nil? ? '' : review.rating.to_i
  end
end
