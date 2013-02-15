class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def user_rating
    review = video.reviews.where(user_id: user.id).first
    review.blank? ? '' : review.rating.to_i
  end

  def self.update_fields(queue_items)
    unless queue_items.blank?
      sorted = queue_items.sort_by { |key, value| value['position'] }
      sorted.each_with_index do |item, index|
        video = self.find(item[0].to_i).video
        user = self.find(item[0].to_i).user
        self.find(item[0].to_i).update_attributes(position: index + 1)
        if item[1]['rating']
          self.update_rating(video, user, item[1]['rating'])
        end
      end
    end
  end

  private
  def self.update_rating(video, user, rating)
    review = Review.where(user_id: user.id, video_id: video.id).first

    if review.blank?
      review = Review.new(user_id: user.id, video_id: video.id, rating: rating.to_i)
      review.save(validate: false)
    else
      review.rating = rating.to_i
      review.save(validate: false)
    end
  end
end
