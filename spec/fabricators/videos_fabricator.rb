Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.sentences(2) }
  small_cover_url { "/tmp/monk.jpg" }
  large_cover_url { "/tmp/monk_large.jpg" }
end