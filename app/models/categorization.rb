class Categorization < ActiveRecord::Base
  # attr_accessible :category_id, :video_id
  belongs_to :video
  belongs_to :category
end
