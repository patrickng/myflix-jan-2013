class Review < ActiveRecord::Base
  validates_presence_of :rating
  validates_presence_of :content

  belongs_to :user
  belongs_to :video
end
