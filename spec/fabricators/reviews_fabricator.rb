Fabricator(:review) do
  rating { rand(1..5) }
  max_rating { 5 }
  review { Faker::Lorem.words(30) }
  user
  video
end