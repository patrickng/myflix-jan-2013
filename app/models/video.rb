class Video < ActiveRecord::Base
  validates :title, presence: "true"
  validates :description, presence: "true"

  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :reviews
  has_many :instant_queue
  has_many :queue_items

  mount_uploader :large_cover, LargeCoverImageUploader
  mount_uploader :small_cover, SmallCoverImageUploader

  def self.search_by_title(title)
    if title.blank?
      []
    else
      where("title LIKE ?", "%#{title}%")
    end
  end

  def rating
    reviews.average(:rating).to_f.round(1)
  end
end
