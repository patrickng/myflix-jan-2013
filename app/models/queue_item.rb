class QueueItem < ActiveRecord::Base
  # attr_accessible :category, :instant_queue_id, :video_rating, :video_title

  belongs_to :instant_queue
end
