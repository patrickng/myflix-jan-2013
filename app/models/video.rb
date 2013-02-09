class Video < ActiveRecord::Base
  validates :title, presence: "true"
  validates :description, presence: "true"

  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :reviews
  has_many :instant_queue
  has_many :queue_items

  def self.search_by_title(title)
    if title.blank?
      []
    else
      where("title LIKE ?", "%#{title}%")
    end
  end

  def in_queue?(user)
    queue_items.exists?(user_id: user.id)
  end
end
