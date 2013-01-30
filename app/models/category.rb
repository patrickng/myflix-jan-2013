class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :categorizations
  has_many :videos, through: :categorizations

  def self.recent_videos
    videos.order('created_at DESC').limit(6)
  end
end
