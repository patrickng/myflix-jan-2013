class Video < ActiveRecord::Base
  attr_accessible :description, :large_cover_url, :small_cover_url, :title

  has_and_belongs_to_many :categories
end
