class Video < ActiveRecord::Base
  attr_accessible :description, :large_cover_url, :small_cover_url, :title

  has_many :categorizations
  has_many :categories, through: :categorizations
end
