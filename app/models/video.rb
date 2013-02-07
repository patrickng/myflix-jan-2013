class Video < ActiveRecord::Base
  validates :title, presence: "true"
  validates :description, presence: "true"

  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :reviews

  def self.search_by_title(title)
    if title.blank?
      []
    else
      where("title LIKE ?", "%#{title}%")
    end
  end
end
