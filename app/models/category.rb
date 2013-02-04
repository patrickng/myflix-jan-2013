class Category < ActiveRecord::Base

  has_many :categorizations
  has_many :videos, through: :categorizations

  validates :description, presence: true
  validates :name, presence: true

  def recent_videos
    videos.order('created_at DESC').limit(6)
  end
end
