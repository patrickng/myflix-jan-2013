Fabricator(:category) do
  name { Faker::Lorem.words(2) }
  description { Faker::Lorem.paragraph(2) }
end