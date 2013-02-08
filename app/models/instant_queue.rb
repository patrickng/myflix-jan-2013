class InstantQueue < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  has_many :queue_items
end
