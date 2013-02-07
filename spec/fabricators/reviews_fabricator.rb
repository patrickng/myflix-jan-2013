Fabricator(:review) do
  rating { sequence(:rating, 1) }
  max_rating { 5 }
  review { "This is a review." }
  user
  video
end