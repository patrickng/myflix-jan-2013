Fabricator(:review) do
  rating { rand(1..5) }
  max_rating { 5 }
  content { Faker::Lorem.sentences(5) }
  user
  video
end