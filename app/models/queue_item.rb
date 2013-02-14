class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def user_rating
    review = video.reviews.where(user_id: user_id).first
    review.nil? ? '' : review.rating.to_i
  end

  def self.reorder(queue_items)
    unless queue_items.nil?
      sorted = queue_items.sort_by { |key, value| value['position'] }
      sorted.each_with_index do |item, index|
        self.find(item[0].to_i).update_attributes(position: index + 1)
      end
    end
  end
end
