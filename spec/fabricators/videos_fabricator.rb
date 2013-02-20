Fabricator(:video) do
  title { Faker::Lorem.words(5) }
  description { Faker::Lorem.sentences(2) }
end