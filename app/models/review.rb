class Review < ActiveRecord::Base
  validates :rating, presence: true
  validates :review, presence: true

  belongs_to :user
  belongs_to :video
end
